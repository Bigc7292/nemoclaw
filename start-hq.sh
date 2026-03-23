#!/bin/bash
# Start CEO-Chief HQ Telegram Bridge and Visual Office

# Load X API variables securely
if [ -f ~/.x_env ]; then
  export $(grep -v '^#' ~/.x_env | xargs)
fi

# Export Telegram & Sandbox configuration
export SANDBOX_NAME='good-skater'
export NVIDIA_API_KEY='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'
export TELEGRAM_BOT_TOKEN='8724242347:AAG0RBT8qQrsL4AFiqlLn33h92YiNdF_2I0'
export ALLOWED_CHAT_IDS='6724992319'
export OPENSHELL_GATEWAY_ENDPOINT='https://127.0.0.1:8080'

echo "=================================================="
echo "STARTING CEO-CHIEF HQ SYSTEMS..."
echo "=================================================="
echo ""
echo "To monitor the agent thinking inside the sandbox, open another Ubuntu terminal and run:"
echo "  openshell term"
echo ""

# Clean up any previously orphaned bridges and Vite dev servers
pkill -9 -f telegram-bridge.js
pkill -9 -f vite || true
fuser -k 5173/tcp 2>/dev/null || true

# Boot the OpenClaw Visual Office frontend in background
if [ -d "$HOME/openclaw-office" ]; then
  echo "=> Booting OpenClaw Visual Office (React/ThreeJS)..."
  cd $HOME/openclaw-office
  
  if [ ! -d "node_modules" ]; then
    echo "=> Installing dashboard dependencies (first run)..."
    npm install
  fi
  
  export VITE_MOCK=false
  npm run dev -- --host --port 5173 --strictPort &
  VISUAL_PID=$!
  sleep 4 # Wait for the server to bind
  echo "=================================================="
  echo "VISUAL OFFICE LIVE AT: http://localhost:5173"
  echo "=================================================="
else
  echo "[!] Visual Office repository not found at ~/openclaw-office"
fi

# Launch the Telegram Bridge (Blocking)
echo "=> Connecting Telegram Bridge..."
cd ~/NemoClaw && /usr/bin/node telegram-bridge-copy.js

# Cleanup if user Ctrl+C's the script
kill -9 $VISUAL_PID 2>/dev/null
