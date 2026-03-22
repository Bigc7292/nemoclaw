# NemoClaw Agent - Telegram Integration Project

## Project Overview
This repository contains the configuration, automation scripts, and policies used to successfully deploy an OpenClaw agent powered by the **NVIDIA NemoClaw** environment, connected directly to a Telegram bot via the `telegram-bridge.js`.

The overarching goal is to define an isolated AI agent environment (sandbox) where the agent can browse the web, write code, run terminals, and execute commands safely using **OpenShell** and **Docker**, while communicating directly with users on Telegram.

## Environment Architecture
* **Host Machine:** Windows (running WSL2).
* **WSL Distribution:** `Ubuntu-22.04` running under user `nemoclaw`.
* **Container Runtime:** Docker (required for OpenShell sandboxes).
* **AI Provider:** NVIDIA API (`nvidia` provider).
* **Agent Engine:** OpenClaw (`nemoclaw` wrapper over OpenClaw).
* **Gateway/Sandbox Engine:** NVIDIA OpenShell (`openshell`).

## Work Completed by the Agent System
1. **Sandbox Cleanup:** Wiped corrupted OpenShell sandboxes, Docker networks, and stale containers that were blocking ports (specifically port 8080 conflicts).
2. **Metadata Reset:** Removed internal config states (`~/.openclaw/sandboxes.json`, `~/.openshell/`) to allow for a clean initialization.
3. **NemoClaw Onboarding:** Bootstrapped a fresh OpenClaw environment mapped to the `my-assistant` sandbox via `NEMOCLAW_RECREATE_SANDBOX=1 nemoclaw onboard --non-interactive`.
4. **Policy Automation:** Authored and executed automated `expect` scripts (`add-policy-v2.exp`) to bypass interactive CLI roadblocks and authorize the `telegram` profile to the `my-assistant` sandbox.
5. **Bridge Execution:** Sourced API credentials and invoked the NemoClaw Telegram bridge script (`telegram-bridge.js`) to establish the connection loop.

## How to Start This in a Different Environment

If another AI agent or developer needs to deploy this setup on a **fresh environment** (e.g. a cloud VM, new WSL instance, or dedicated server), follow these steps:

### Prerequisites
1. **OS:** Linux (Ubuntu 22.04+ recommended) or WSL2.
2. **Docker:** Docker Engine/Docker Desktop must be running.
3. **Node.js:** v18+ is required.

### 1. Install NemoClaw & OpenShell
Run the official NVIDIA installation script to install the CLI and gateway components.
```bash
curl -fsSL https://nvidia.com/nemoclaw.sh | bash
```
*(Verify by running `nemoclaw --version` and `openshell --version`)*

### 2. Configure Environment Variables
Set the following keys in your environment (e.g. `~/.bashrc` or directly in the terminal session):
```bash
export TELEGRAM_BOT_TOKEN="your_telegram_bot_token"
export NVIDIA_API_KEY="your_nvidia_api_key_starting_with_nvapi-"
export SANDBOX_NAME="my-assistant"
```

### 3. Initialize the Sandbox
Onboard the agent with the NVIDIA provider. Use the `--non-interactive` flag if automating.
```bash
nemoclaw onboard --non-interactive
```
*Note: If a sandbox already exists and you want to wipe it, set `NEMOCLAW_RECREATE_SANDBOX=1` before running the command.*

### 4. Apply Network Policies
The agent is sandboxed by default. You must grant it outbound network access to Telegram.
```bash
nemoclaw my-assistant policy-add telegram
```
*(If the CLI prompts interactively, you can use the `add-policy-v2.exp` Expect script located in this repository).*

### 5. Start the Telegram Bridge
Execute the bridge script. The exact path depends on your NPM global installations.
```bash
node ~/.npm-global/lib/node_modules/nemoclaw/scripts/telegram-bridge.js
```
The agent is now online and bound to your Telegram Bot.

### 6. Managing the Sandbox/Gateway
To monitor or approve unexpected actions (like when the agent needs manual confirmation):
- Run `openshell term` in an adjoining terminal.
- This will open the terminal user interface (TUI) to watch sandbox egress/ingress logs.

## Missing Components / Analysis (Compared to Official Repo)
Based on the official `nvidia/nemoclaw` architecture, this repository currently functions purely as the runtime initialization mapping. To fully utilize NemoClaw's capabilities locally, the following features or files from the "Awesome NemoClaw" configurations could/should be integrated here:
1. **Custom `openshell` Profiles (`ultimate.yaml`):** Advanced presets (like PyPI, NPM, Github) should be statically defined here so agents have web capabilities.
2. **Prompts & Agent Instruction Headers:** We rely on the default OpenClaw persona. The official stack recommends injecting a specific System Prompt tailored for Telegram.
3. **Persisted File Mounts:** The Sandbox resets its state. We need to create bound directories to ensure file generation/coding isn't lost when the container stops.
