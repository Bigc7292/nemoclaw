# Competition Research Skills

## Intelligence Gathering
- **Social Monitoring**: Track competitor X/Twitter accounts
- **Content Analysis**: What works, what doesn't
- **Audience Mining**: Their followers, engagement patterns
- **Product Tracking**: New offerings, pricing changes
- **SEO Spy**: Keywords they rank for
- **Ad Intelligence**: Their promotional strategies

## Tools & Sources
- **Twitter API**: Competitor posts, engagement metrics
- **competitor-intel.json**: Historical tracking database
- **intel-feed.json**: Real-time market signals
- **Web Search**: News, press releases, job postings
- **SimilarWeb/Social Blade**: Traffic, follower stats

## Competitor Profile Template
```json
{
  "competitor_name": "string",
  "platforms": ["twitter", "instagram", "fanvue", "etc"],
  "followers": {
    "twitter": "number",
    "instagram": "number"
  },
  "posting_frequency": {
    "twitter": "posts_per_day",
    "other": "posts_per_week"
  },
  "content_themes": ["primary topics covered"],
  "monetization": ["revenue streams identified"],
  "strengths": ["what they do well"],
  "weaknesses": ["what they do poorly or miss"],
  "recent_moves": ["last 5 notable actions"],
  "threat_level": "high|medium|low",
  "opportunity": "how we can outcompete",
  "last_updated": "ISO-8601"
}
```

## Workflow
1. Pull latest data from competitor accounts
2. Compare against historical competitor-intel.json
3. Note significant changes (new posts, follower spikes)
4. Analyze top-performing content
5. Update competitor-intel.json
6. Push critical intel to intel-feed.json
7. Alert CEO-Chief of high-priority findings

## Content Spy Techniques
- Track engagement on their posts (what resonates)
- Monitor their hashtags and mentions
- Analyze their posting times (optimal timing?)
- Study their replies (community management style)
- Watch their retweets/engagement with others

## Competitive Playbook

### If competitor goes viral:
1. Analyze WHY it went viral
2. Create similar content with our twist
3. Post faster than they can follow up
4. Engage with commenters to ride the wave

### If competitor launches new product:
1. Research the offering immediately
2. Identify gaps we can fill
3. Prepare counter-content
4. Flag to CEO-Chief for strategic response

### If competitor loses ground:
1. Identify why (algorithm change? scandal? fatigue?)
2. Target their abandoned audience
3. Create content addressing their failures
4. Accelerate our momentum

## Alert Triggers
- Competitor gains 10%+ followers in 48hrs
- Major partnership announcement
- Viral post with 100k+ engagements
- New platform launch
- Pricing change
- Public controversy
