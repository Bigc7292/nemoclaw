const auth = {"nvidia:manual":{"type":"api_key","provider":"nvidia","keyRef":{"source":"env","id":"NVIDIA_API_KEY"},"profileId":"nvidia:manual"}};
require("fs").writeFileSync("/tmp/auth.json", JSON.stringify(auth));
console.log("done");
