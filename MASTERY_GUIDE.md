# NemoClaw Mastery Guide

This document is the "brain dump" for mastering the **NVIDIA NemoClaw** and **OpenShell** ecosystem. Use this to maintain, scale, or migrate your agent.

## 1. The Core Infrastructure
* **OpenShell Gateway**: This is the heart of the system. It runs as a set of Docker containers that manage the "Gatekeeper" (K3s). Always start your troubleshooting here.
* **The Sandbox**: Every agent lives in an ephemeral sandbox. Files created there are lost unless you mount a volume (Advanced).
* **Network Policies**: By default, the sandbox is "air-gapped" (no internet). You must "add policies" to let it talk to things like Telegram, Github, or NPM.

## 2. Power-User Commands (Cheat Sheet)
Run these inside your WSL `Ubuntu-22.04` instance (user: `nemoclaw`):

| Action | Command |
| :--- | :--- |
| **Monitor Live** | `openshell term` (The TUI - essential for debugging) |
| **Check Sandbox** | `openshell sandbox list` |
| **Destroy All** | `openshell sandbox destroy --all` (The "Panic Button") |
| **Add Bridge Perms** | `nemoclaw <name> policy-add telegram` |
| **Check Logs** | `nemoclaw <name> logs --follow` |

## 3. How to "Master" the Architecture
To truly maximize NemoClaw, you should focus on these three layers:

### A. Policy Engineering (The Security Layer)
Don't just use default policies. Create your own `yaml` files to restrict the agent only to specific domains.
* *Pro Tip:* Look at the `v3_policy.yaml` in this repo for a more restricted template.

### B. The Bridge Layer (The Communication Layer)
The `telegram-bridge.js` is a standard Node.js app. You can modify it to:
* Support multi-user Chat IDs.
* Add specialized commands like `/reset` (which could trigger a sandbox wipe).
* Add image/file upload handling (currently it mainly handles text).

### C. The Skill Registry
NemoClaw agents are "born" with tools. You can extend these by:
1. Adding NPM packages to the global space.
2. Granting the `npm` policy to the sandbox.
3. Telling the agent (via system prompt) that it has access to those terminal commands.

## 4. Troubleshooting the "Infinite Loop"
If the agent stops replying:
1. **Check Docker**: Run `docker ps`. If the gateway containers aren't running, restart Docker Desktop.
2. **Check Port 8080**: This is the OpenShell API port. If it's blocked by another app (like a web server or proxy), the gateway will crash.
3. **Restart the Bridge**: Kill the node process and run it again using the environment variables.

---
*For a full setup history and cross-environment deployment steps, refer to the [README.md](file:///c:/Users/toplo/.gemini/antigravity/playground/aphelion-skylab/README.md) in the root directory.*
