const fs = require("fs");
const auth = {"nvidia:manual":{"type":"api_key","provider":"nvidia","keyRef":{"source":"env","id":"NVIDIA_API_KEY"},"profileId":"nvidia:manual"}};
fs.writeFileSync("/sandbox/.openclaw/agents/main/agent/auth-profiles.json", JSON.stringify(auth, null, 2));
console.log("Auth profile written");
