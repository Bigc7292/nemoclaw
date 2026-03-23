const fs = require("fs");
const b64 = fs.readFileSync("/tmp/auth_b64.txt", "utf8").trim();
const auth = Buffer.from(b64, "base64").toString();
fs.writeFileSync("/sandbox/.openclaw/agents/main/agent/auth-profiles.json", auth);
console.log("Written:", auth);
