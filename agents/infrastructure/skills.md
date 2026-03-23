# Infrastructure Skills

## System Components

### NemoClaw Stack
- **Runtime**: Node.js (check with `node --version`)
- **Package Manager**: npm/pnpm
- **Global Scripts**: `~/.npm-global/lib/node_modules/nemoclaw/`
- **System Prompt**: `~/.npm-global/lib/node_modules/nemoclaw/scripts/system_prompt.txt`

### Agent Files
- **Skills**: `~/.agents/skills/`
- **Souls**: Stored per agent in `~/.agents/`
- **Shared Brain**: `~/shared-brain/`

### Bridge Services
- **Telegram Bridge**: `telegram-bridge-copy.js`
  - Bot Token: `8724242347:AAG0RBT8qQrsL4AFiqlLn33h92YiNdF_2I0`
  - Webhook/polling hybrid mode
- **Start Script**: `~/start-hq.sh`

## Health Checks

### Daily System Check
```bash
# Check if NemoClaw is running
ps aux | grep nemoclaw
pgrep -f openclaw

# Check node processes
ps aux | grep node

# Check disk space
df -h

# Check memory
free -m

# Check logs
tail -50 ~/.npm-global/lib/node_modules/nemoclaw/logs/*.log
```

### Telegram Bridge Check
```bash
# Test bot is responding
curl -s "https://api.telegram.org/bot8724242347:AAG0RRT8qQrsL4AFiqlLn33h92YiNdF_2I0/getMe"

# Check pending updates
curl -s "https://api.telegram.org/bot8724242347:AAG0RRT8qQrsL4AFiqlLn33h92YiNdF_2I0/getUpdates"
```

## Common Operations

### Restart HQ
```bash
# Via the start script
~/start-hq.sh

# Manual restart
killall node
cd ~
nohup nemoclaw my-assistant &
```

### Check Shared Brain
```bash
# View task queue
cat ~/shared-brain/task-queue.json | jq

# View intel feed
cat ~/shared-brain/intel-feed.json | jq

# Monitor in real-time
tail -f ~/shared-brain/*.json
```

### Clear Orphaned Processes
```bash
killall node
pkill -f telegram-bridge
```

## Backup Procedures

### Shared Brain Backup
```bash
# Create backup directory
mkdir -p ~/backups/$(date +%Y%m%d)

# Backup shared brain
cp -r ~/shared-brain/* ~/backups/$(date +%Y%m%d)/

# Backup agent configs
cp -r ~/.agents ~/backups/$(date +%Y%m%d)/agents.bak
```

### Restore from Backup
```bash
# Stop services
killall node

# Restore
cp -r ~/backups/YYYYMMDD/* ~/shared-brain/

# Restart
~/start-hq.sh
```

## Monitoring

### API Credentials Check
```bash
# Check if X credentials loaded
source ~/.x_env
echo $X_BEARER_TOKEN

# Check NVIDIA API
curl -s -H "Authorization: Bearer $NVIDIA_API_KEY" \
  "https://api.nvidia.com/v1/infra/direct/us-east/availability"
```

### Log Locations
- NemoClaw: `~/.npm-global/lib/node_modules/nemoclaw/logs/`
- Telegram Bridge: Console output (when running)
- System: `/var/log/syslog`

## Performance Optimization

### Memory Usage
```bash
# Check Node memory
node -e "console.log(process.memoryUsage())"

# Optimize shared-brain JSON (remove old entries)
# Use jq to filter recent items
jq '.[] | select(.timestamp > "2024-01-01")' ~/shared-brain/task-queue.json > temp.json
mv temp.json ~/shared-brain/task-queue.json
```

## Security

### File Permissions
```bash
# Secure credentials
chmod 600 ~/.x_env
chmod 700 ~/shared-brain
chmod -R 700 ~/.agents
```

### API Key Rotation
1. Generate new keys on provider dashboard
2. Update `~/.x_env` or relevant config
3. Test connectivity
4. Revoke old keys
5. Document in system architecture

## Troubleshooting

### Bot Not Responding
1. Check Telegram bot token validity
2. Verify webhook is set correctly
3. Check if bot has pending updates (drain them)
4. Restart bridge service
5. Check firewall/network connectivity

### Agent Not Responding
1. Check if NemoClaw process running
2. Verify shared-brain files are valid JSON
3. Check disk space
4. Review recent logs
5. Restart NemoClaw service

### High Memory/CPU
1. Identify culprit process
2. Check for memory leaks in custom scripts
3. Optimize JSON file sizes
4. Restart affected services
