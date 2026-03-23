# Adult Influencer Russian Skills

## Content Creation

### Image Generation
Use NVIDIA API or Hugging Face Spaces for ultra-realistic images:

```bash
# NVIDIA API - Ultra realistic
curl -X POST "https://ai.api.nvidia.com/v1/genai/stabilityai/stable-diffusion-xl" \
  -H "Authorization: Bearer $NVIDIA_API_KEY" \
  --data '{
    "prompt": "beautiful woman, russian features, premium photography, 8k, detailed, realistic",
    "width": 1024,
    "height": 1024,
    "steps": 30,
    "guidance_scale": 7.5
  }'

# Hugging Face Flux
curl -X POST "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-dev" \
  -H "Authorization: Bearer $HF_TOKEN" \
  --data '{"inputs": "your detailed prompt"}'
```

### Proven Image Prompts
```python
PROMPTS = {
    "portrait": "stunning portrait, russian adult influencer style, soft lighting, 8k, photorealistic, high detail",
    "lifestyle": "beautiful woman in luxury setting, confident pose, editorial photography, 8k",
    "teaser": "alluring but tasteful preview, artistic composition, fashion photography style",
    "bathroom_mirror": "bathroom mirror selfie confidence, natural lighting, realistic, 8k detail"
}
```

### X/Twitter Post Templates

```python
TWEET_TEMPLATES = {
    "teaser": [
        "New content just dropped 🔥 [brief provocative caption]",
        "You don't want to miss this one 😏 [link]",
        "My fans get the best content... are you one of them? [link]"
    ],
    "exclusive": [
        "Full video on Fanvue now 💦 [link]",
        "This one was requested a lot... hope you enjoy 😈 [link]",
        "Private content just for my true fans... [link]"
    ],
    "engagement": [
        "What's your favorite? A, B, or C? 👀 [poll]",
        "Tell me in the comments what you want next...",
        "I read every reply personally 💋"
    ],
    "lifestyle": [
        "Behind the scenes from today's shoot 📸",
        "People ask how I stay confident... [thought]",
        "Moscow life vs LA plans 🌍"
    ]
}
```

## Workflow

### Daily Content Cadence
1. **Morning**: Check analytics, engage with comments
2. **Afternoon**: Create/tease new content
3. **Evening**: Post peak-time content, run engagement posts
4. **Night**: DM outreach, community management

### Content Pipeline
1. Generate images via NVIDIA/Hugging Face
2. Select best outputs (rate 1-5)
3. Write caption (hook + value + link)
4. Schedule via content-calendar.json
5. Post with tracking links
6. Monitor engagement
7. Respond to comments within 1 hour

### Fanvue Funnel
```
X Post (teaser + link) 
  → Click through to Fanvue 
  → Subscribe ($X/month) 
  → Access exclusive content
  → Upsell: Custom content, messages, video calls
```

## Analytics to Track
- **X**: Impressions, engagements, link clicks, follower growth
- **Fanvue**: Subscribers, retention, revenue, requests fulfilled
- **Conversion**: X followers → Fanvue subscribers (target: 2-5%)
- **Best posting times**: Track engagement by hour/day

## Engagement Scripts

### Comment Replies
```python
REPLY_TEMPLATES = {
    "flirty": [
        "You're cute when you're thirsty 😏",
        "Keep commenting and maybe I'll notice you 💋",
        "My favorite fan right here 🔥"
    ],
    "appreciative": [
        "Thank you baby, means a lot 💕",
        "You always support me, I appreciate you!",
        "Made my day with this comment 😘"
    ],
    "mysterious": [
        "Maybe you'll find out... 😈",
        "That's a secret I'll never tell",
        "Keep guessing 😉"
    ]
}
```

### DM Scripts
```python
DM_TEMPLATES = {
    "new_follower": "Hey baby, thanks for following 💋 Check out my exclusive content on Fanvue 👇 [link]",
    "top_fan": "I noticed you've been supporting me a lot... I have something special planned for fans like you 😏",
    "custom_request": "I love custom content requests! Drop me a message with what you have in mind and we'll talk 💦"
}
```

## Brand Voice Examples

### Post Style Examples
```
🔥 "Another day, another reason to check my Fanvue. You know you want to 👀 [link]"

😏 "Russian winters are cold... my DMs are hot 🔥"

💋 "My Lipsyncantai viral last night. You guys wanted more... here it is 👉 [Fanvue link]"

📸 "No makeup. No filters. Just me. The realest you'll get 💕 [image]"
```

## Hashtag Strategy
```python
HASHTAGS = {
    "broad": ["#Adult", "#18Plus", "#NSFW", "#PremiumContent"],
    "platform": ["#Fanvue", "#OnlyFans", "#ContentCreator"],
    "niche": ["#RussianGirl", "#EasternEuropean", "#Curvy", "#BBW"],
    "engagement": ["#FollowMe", "#Subscribe", "#Exclusive", "#VIP"]
}
```

## Compliance
- Never depict minors (age verification required)
- No illegal content
- Respect platform-specific rules
- Clear consent for any collaborative content
- geo-restriction on sensitive content where required
