const fs = require("fs");
const auth = {"nvidia:manual":{"type":"api_key","provider":"nvidia","keyRef":{"source":"env","id":"NVIDIA_API_KEY"},"profileId":"nvidia:manual"}};
const content = JSON.stringify(auth);
const b64 = Buffer.from(content).toString("base64");
fs.writeFileSync("/tmp/auth_b64.txt", b64);
console.log("b64:", b64);
