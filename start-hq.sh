#!/bin/bash
# CEO-Chief HQ - Single command launcher
# Works from any terminal (no systemd user session required)
#
# SECRETS: Never hardcode keys here.
# Place your real values in ~/.hq.env (chmod 600, never commit to git).
#
# ~/.hq.env format:
#   NVIDIA_API_KEY=nvapi-...
#   TELEGRAM_BOT_TOKEN=...
#   ALLOWED_CHAT_IDS=...
#   SANDBOX_NAME=my-assistant   # optional, defaults below

ENV_FILE="$HOME/.hq.env"

if [ ! -f "$ENV_FILE" ]; then
  echo ""
  echo "  ERROR: $ENV_FILE not found."
  echo ""
  echo "  Create it with:"
  echo "    touch ~/.hq.env && chmod 600 ~/.hq.env"
  echo ""
  echo "  Then add these lines:"
  echo "    NVIDIA_API_KEY=nvapi-..."
  echo "    TELEGRAM_BOT_TOKEN=..."
  echo "    ALLOWED_CHAT_IDS=your_telegram_chat_id"
  echo "    SANDBOX_NAME=my-assistant"
  echo ""
  exit 1
fi

# Load secrets — file is only readable by you
set -a
# shellcheck source=/dev/null
source "$ENV_FILE"
set +a

# Defaults if not set in env file
SANDBOX_NAME="${SANDBOX_NAME:-my-assistant}"
PIDFILE=/tmp/hq-pids

# Validate required vars
missing=0
for var in NVIDIA_API_KEY TELEGRAM_BOT_TOKEN ALLOWED_CHAT_IDS; do
  if [ -z "${!var}" ]; then
    echo "  ERROR: $var is not set in $ENV_FILE"
    missing=1
  fi
done
if [ "$missing" -eq 1 ]; then
  echo "  Fix $ENV_FILE and try again."
  exit 1
fi

export SANDBOX_NAME
export NVIDIA_API_KEY
export TELEGRAM_BOT_TOKEN
export ALLOWED_CHAT_IDS

echo "=================================================="
echo " CEO-CHIEF HQ - STARTING UP"
echo "=================================================="
echo "  Sandbox : $SANDBOX_NAME"
echo "  Bot     : set"
echo "  API key : ${NVIDIA_API_KEY:0:12}..."
echo "=================================================="

# 1. Kill any old HQ processes
echo "=> Stopping old processes..."
if [ -f "$PIDFILE" ]; then
  while IFS= read -r pid; do
    kill "$pid" 2>/dev/null || true
  done < "$PIDFILE"
  rm -f "$PIDFILE"
fi
killall node 2>/dev/null || true
fuser -k 5173/tcp 2>/dev/null || true
openshell forward stop 18789 2>/dev/null || true
sleep 1

# 2. Verify gateway and sandbox
echo "=> Checking OpenShell gateway..."
if ! docker ps --filter name=openshell --format '{{.Status}}' 2>/dev/null | grep -q healthy; then
  echo "   Gateway not healthy - starting..."
  openshell gateway start 2>/dev/null &
  echo "   Waiting up to 2 minutes for gateway..."
  for i in $(seq 1 24); do
    sleep 5
    if docker ps --filter name=openshell --format '{{.Status}}' 2>/dev/null | grep -q healthy; then
      echo "   Gateway healthy!"
      break
    fi
    echo "   Still waiting... ($((i*5))s)"
  done
fi

echo "=> Checking sandbox..."
if ! openshell sandbox list 2>/dev/null | grep -q "$SANDBOX_NAME"; then
  echo "   Sandbox '$SANDBOX_NAME' not found - run setup first!"
  exit 1
fi
echo "   Sandbox ready."

# 3. Generate SSH config for sandbox
openshell sandbox ssh-config "$SANDBOX_NAME" > /tmp/gw-ssh.conf 2>/dev/null
echo "=> SSH config written."

# 4. Start OpenClaw gateway inside sandbox
echo "=> Starting OpenClaw gateway inside sandbox..."
ssh -T -F /tmp/gw-ssh.conf "openshell-${SANDBOX_NAME}" \
  "NVIDIA_API_KEY=${NVIDIA_API_KEY} nohup nemoclaw-start > /tmp/gateway.log 2>&1 &" \
  2>/dev/null \
  && echo "   Gateway started." \
  || echo "   [WARN] Gateway SSH failed (may already be running)"
sleep 3

# 5. Get fresh auth token
GW_TOKEN=$(ssh -T -F /tmp/gw-ssh.conf "openshell-${SANDBOX_NAME}" \
  'python3 -c "import json,os; cfg=json.load(open(os.path.expanduser(\"~/.openclaw/openclaw.json\"))); print(cfg[\"gateway\"][\"auth\"][\"token\"])"' \
  2>/dev/null || echo "")
if [ -n "$GW_TOKEN" ]; then
  echo "=> Gateway token acquired."
else
  echo "=> [WARN] Could not retrieve gateway token."
fi

# 6. Forward port 18789
echo "=> Forwarding port 18789..."
openshell forward start 18789 "$SANDBOX_NAME" --background 2>/dev/null \
  && echo "   Port 18789 forwarded." \
  || echo "   [WARN] Port forward failed"

# 7. Start Visual Office
echo "=> Starting Visual Office on port 5173..."
cd /home/nemoclaw/openclaw-office || { echo "openclaw-office not found - skipping Visual Office"; VITE_PID=0; }
if [ "$(pwd)" = "/home/nemoclaw/openclaw-office" ]; then
  VITE_MOCK=false \
  VITE_GATEWAY_URL=ws://127.0.0.1:18789 \
  VITE_GATEWAY_TOKEN=$GW_TOKEN \
    nohup npm run dev -- --host --port 5173 --strictPort > /tmp/vite.log 2>&1 &
  VITE_PID=$!
  echo "$VITE_PID" >> "$PIDFILE"
  sleep 4
fi

# 8. Start Cloud Telegram Bridge (no openshell deps)
echo "=> Starting Telegram Bridge..."
BRIDGE_SCRIPT=""
for candidate in \
  "/home/nemoclaw/NemoClaw/cloud-bridge.js" \
  "$HOME/NemoClaw/cloud-bridge.js" \
  "$(dirname "$0")/cloud-bridge.js"; do
  if [ -f "$candidate" ]; then
    BRIDGE_SCRIPT="$candidate"
    break
  fi
done

if [ -z "$BRIDGE_SCRIPT" ]; then
  echo "  ERROR: cloud-bridge.js not found. Check your NemoClaw directory."
  exit 1
fi

nohup /usr/bin/node "$BRIDGE_SCRIPT" > /tmp/bridge.log 2>&1 &
BRIDGE_PID=$!
echo "$BRIDGE_PID" >> "$PIDFILE"
sleep 3

# 9. Status report
echo ""
echo "=================================================="
echo " STARTUP COMPLETE"
echo "=================================================="
echo ""
if kill -0 "$BRIDGE_PID" 2>/dev/null; then
  echo "  Telegram bridge : RUNNING (pid $BRIDGE_PID)"
else
  echo "  Telegram bridge : FAILED - check /tmp/bridge.log"
  echo "  Run: tail -f /tmp/bridge.log"
fi
if [ -n "$VITE_PID" ] && [ "$VITE_PID" -ne 0 ]; then
  if kill -0 "$VITE_PID" 2>/dev/null; then
    echo "  Visual Office   : RUNNING (pid $VITE_PID)"
  else
    echo "  Visual Office   : FAILED - check /tmp/vite.log"
  fi
fi
echo ""
echo "  Telegram Bot    : @chiefcommanderaibot"
if [ -n "$GW_TOKEN" ]; then
  echo "  Visual Office   : http://localhost:5173/#token=${GW_TOKEN}"
else
  echo "  Visual Office   : http://localhost:5173"
fi
echo ""
echo "  Monitor bridge  : tail -f /tmp/bridge.log"
echo "  Monitor agent   : openshell term"
echo "  Stop all        : kill \$(cat $PIDFILE)"
echo "=================================================="
echo ""
echo "Bot is live. Open Telegram and message @chiefcommanderaibot"
