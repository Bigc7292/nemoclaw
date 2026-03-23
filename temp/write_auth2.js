const auth = {
  "nvidia:manual":{"type":"api_key","provider":"nvidia","keyRef":{"source":"env","id":"NVIDIA_API_KEY"},"profileId":"nvidia:manual"},
  "anthropic:manual":{"type":"api_key","provider":"anthropic","keyRef":{"source":"env","id":"ANTHROPIC_API_KEY"},"profileId":"anthropic:manual"}
};
require("fs").writeFileSync("/tmp/auth_with_anthropic.json", JSON.stringify(auth));
console.log("done");
