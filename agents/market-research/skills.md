# Market Research Skills

## Data Collection
- **Web Scraping**: Fetch real-time data from target sites
- **API Calls**: Twitter API, public data sources
- **Manual Curation**: Extract key metrics from reports
- ** competitor-intel.json**: Historical baseline data

## Analysis Frameworks
- **SWOT Analysis**: Strengths, weaknesses, opportunities, threats
- **5 Forces**: Industry competitive intensity
- **Trend Analysis**: YoY, MoM, WoW comparisons
- **Cohort Analysis**: User behavior segmentation
- **Gap Analysis**: Market opportunities

## Tools & Resources
- **Hugging Face**: Text analysis models
- **Web Search**: trend_data, market reports
- **Twitter API**: Sentiment analysis, trending topics
- **Google Trends**: Search volume insights

## Output Templates

### Market Pulse Report
```json
{
  "date": "ISO-8601",
  "summary": "2-3 sentence overview",
  "trends": [
    {
      "topic": "string",
      "direction": "rising|falling|stable",
      "confidence": "high|medium|low",
      "source": "url or citation"
    }
  ],
  "opportunities": ["actionable items"],
  "threats": ["risks to monitor"],
  "recommendations": ["what to do next"]
}
```

### Competitor Snapshot
```json
{
  "competitor_name": "string",
  "last_updated": "ISO-8601",
  "followers": "number",
  "engagement_rate": "float",
  "posting_frequency": "posts_per_week",
  "top_content": ["list of best performers"],
  "monetization": "known revenue streams",
  "gaps": ["what they're not doing"]
}
```

## Workflow
1. Check task-queue.json for research requests
2. Define research scope and success metrics
3. Gather data from multiple sources
4. Analyze and synthesize findings
5. Write report to intel-feed.json
6. Update competitor-intel.json with new data
7. Flag high-priority findings to CEO-Chief

## Key Metrics to Track
- Follower growth rates
- Engagement rates (likes, comments, shares)
- Content velocity (posts per day/week)
- Audience demographics
- Revenue per follower
- Conversion rates
- Sentiment scores

## Data Quality Checks
- Cross-reference multiple sources
- Check data freshness (timestamp)
- Validate sample sizes
- Note margin of error
- Flag estimates vs. confirmed data
