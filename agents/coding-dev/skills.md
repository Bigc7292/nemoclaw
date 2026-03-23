# Coding/Dev Skills

## Languages & Frameworks
- **Frontend**: React, Vite, TypeScript, Tailwind CSS
- **Backend**: Node.js, Python (FastAPI, Flask)
- **Scripting**: Bash, PowerShell, Python
- **Database**: PostgreSQL, SQLite, JSON files

## Tools & Environment
- **NemoClaw/OpenShell**: Agent runtime environment
- **npm/pnpm**: Package management
- **Docker**: Containerization for deployments
- **Git**: Version control (branching, PRs, merges)
- **WSL**: Linux tooling on Windows

## Key Scripts & Paths
- `~/start-hq.sh`: HQ launch orchestration
- `~/shared-brain/`: Inter-agent JSON communication
- `~/.x_env`: Twitter API credentials
- `telegram-bridge.js`: Telegram-NemoClaw bridge

## Development Workflow
1. Receive task from task-queue.json
2. Create feature branch: `git checkout -b feature/name`
3. Implement with test coverage
4. Self-review code changes
5. Update task-queue.json with completion status
6. Notify relevant agent via intel-feed.json

## Code Templates

### Node.js Script Template
```javascript
#!/usr/bin/env node
/**
 * [Script Name]
 * [Brief description]
 */

const fs = require('fs');
const path = require('path');

// Configuration
const CONFIG = {
  // ...
};

// Main execution
async function main() {
  try {
    // Implementation
    console.log('[INFO] Starting...');
  } catch (error) {
    console.error('[ERROR]', error.message);
    process.exit(1);
  }
}

main();
```

### Python Script Template
```python
#!/usr/bin/env python3
"""
[Script Name]
[Brief description]
"""

import json
import sys
from pathlib import Path

CONFIG = {
    # ...
}

def main():
    try:
        print("[INFO] Starting...")
    except Exception as e:
        print(f"[ERROR] {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
```

## API Integration Patterns
- Twitter API v2: OAuth 1.0a for posting
- Telegram Bot API: Webhook + polling hybrid
- NVIDIA API: REST calls for image generation
- Hugging Face: Inference API for models

## File Operations
- Read: `fs.readFileSync` / `json.load`
- Write: `fs.writeFileSync` with atomic writes
- Paths: Use `path.join` for cross-platform compatibility

## Debugging
- Add console.log/print statements with timestamps
- Check shared-brain JSON structure
- Verify API credentials are loaded
- Test in isolation before deployment

## Cron Jobs
- Use `crontab -e` for scheduling
- Common pattern: `0 9 * * * /path/to/script.sh`
- Log output to files for monitoring
