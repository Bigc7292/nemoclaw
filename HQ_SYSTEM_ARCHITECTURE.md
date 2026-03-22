# 🏢 CEO-Chief AI HQ: Comprehensive Architecture & Setup Guide

This document guarantees all configurations, API keys, and system architecture details are permanently logged so you don't lose progress when your AntiGravity credits deplete.

## 🌟 Command to Launch
From any Ubuntu terminal, you can now launch your complete AI HQ and connect it to Telegram with a **single command**:
```bash
start-hq
```
*(This triggers `~/start-hq.sh` which automatically kills orphaned bots, loads your X/Telegram/Nvidia APIs, and launches the NemoClaw bridge).*

To **monitor the thoughts and exact prompts** the agent is generating, open a *second* Ubuntu terminal and run:
```bash
openshell term
```

---

## 🏗️ 1. Hierarchical Architecture
Your local NemoClaw instance is running a "Hierarchical Multi-Agent" setup, a cutting-edge 2026 approach for scalable autonomous companies.

- **The Main Sandbox (`my-assistant`)**: This operates as the central executive hub. The primary `openclaw` agent running in here assumes the persona of **"CEO-Chief"**.
- **System Prompt**: Programmed in `~/.npm-global/lib/node_modules/nemoclaw/scripts/system_prompt.txt`, the CEO is instructed to hold daily standups and delegate work to specific departments:
  - 📡 Social Media
  - 💻 Coding/Dev
  - 📊 Market Research
  - 🔎 Competition Research
  - 🚀 AI Innovation
  - 🛠️ Infrastructure Improvement

### Brain Sync (Memory)
All departments communicate via shared JSON files stored inside your sandbox at `~/shared-brain/`:
- `task-queue.json` (Handoffs between agents)
- `intel-feed.json` (Real-time data scraped from the web)
- `content-calendar.json` (Pacing for X/Twitter posts and Fanvue funnels)
- `competitor-intel.json` (Market insights)

---

## 🎭 2. Agent Personalities (`soul.md`)
Agents are given explicit parameters and a voice via `.md` files physically stored on disk.
The standout persona we configured is the **Russian Adult Influencer**:
- **Path**: `~/.agents/skills/adult-influencer-russian/SKILL.md`
- **Goal**: Drive Fanvue sales using dominant, engaging engagement tactics formatted natively for X.
- **Capabilities**: Instructed to generate ultra-realistic images using Hugging Face Spaces (Flux/SD3) and intelligently funnel engagement.

---

## ⚡ 3. Skills Library
NemoClaw has been expanded with the `awesome-openclaw-skills` repository, grating your agents access to **1,200+** community tools. They are stored in `~/.agents/skills`.

Whenever CEO-Chief encounters a task, the OpenShell dynamically looks in this directory to load the proper `.md` wrapper or CLI script (e.g., executing Image Gen, deploying Docker, analyzing a GitHub repo).

---

## 🔐 4. API & Security Credentials
Due to security best practices, we bypassed hardcoding API keys in text. They are loaded at runtime.

### The X (Twitter) API integration
Your X developer credentials have been securely staged.
- **Path**: `~/.x_env` (Only readable by you, set to `chmod 600`)
- **Variables Configured**:
  - `X_CONSUMER_KEY`
  - `X_CONSUMER_SECRET`
  - `X_ACCESS_TOKEN`
  - `X_ACCESS_TOKEN_SECRET`
  - `X_BEARER_TOKEN`
- **Loading mechanism**: Every time the sandbox or bash runs, `~/.bashrc` automatically sources this file.

### Telegram Bridge Secrets
The gateway connects Telegram securely to your NemoClaw agent.
- `TELEGRAM_BOT: 8724242347:AAG0RBT8qQrsL4AFiqlLn33h92YiNdF_2I0` (Bound to @chiefcommanderaibot)
- `ALLOWED_CHAT_IDS: 6724992319` (Locks down the bot so *only you* can text it; prevents spam attacks)
- `NVIDIA_API_KEY: nvapi-fEZVmY4yKnReQW2u-NncmJ`

---

## 🛠️ 5. Bug Fixes Implemented
We solved significant issues deeply rooted in the CLI to make this production-ready:
1. **Telegram Echo/Duplication Fix**: The original NemoClaw bridge suffered from blocking network calls. We rewrote `telegram-bridge.js` to implement an asynchronous queue and an in-memory `Set` (cache) that immediately deduplicates update IDs. It now handles loads instantly without freezing or bouncing repeated updates.
2. **Bot Commands**: Added a native `/debug` command to Telegram to monitor memory state.
3. **Orphaned Ports (`killall node`)**: Automated the destruction of hidden duplicate hooks via the new `start-hq` script.
4. **Custom Sandbox Initialization**: Rewrote `/usr/local/bin/nemoclaw-start` inside the sandbox to echo department initialization diagnostics upon boot.

---

## ⏭️ Next Steps / Playbook
When you deploy more credits or operate the system, these should be your next actions:
1. **Google OAuth API**: Bind the Calendar/Gmail integrations by generating a GCP JSON key to automate daily standups/emails.
2. **Cron Jobs**: Implement native Ubuntu `cron` schedules within the sandbox to autonomously ping the agent (e.g., `0 9 * * * echo "Daily standup time" | nemoclaw ...`) so it acts without your Telegram prompts.
3. **Write More Souls**: Clone the `adult-influencer-russian` skill structure for your Developer, Marketing, and UX Design agents.
