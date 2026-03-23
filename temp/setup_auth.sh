#!/bin/bash
mkdir -p /sandbox/.openclaw/agents/main/agent
cat > /sandbox/.openclaw/agents/main/agent/auth-profiles.json << 'AUTHEOF'
{"nvidia:manual":{"type":"api_key","provider":"nvidia","keyRef":{"source":"env","id":"NVIDIA_API_KEY"},"profileId":"nvidia:manual"}}
AUTHEOF
cat /sandbox/.openclaw/agents/main/agent/auth-profiles.json
