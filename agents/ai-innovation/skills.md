# AI Innovation Skills

## AI Models & Platforms
- **OpenAI**: GPT-4, GPT-4o, Assistants API
- **Anthropic**: Claude 3.5, Opus, Sonnet
- **Google**: Gemini, Imagen
- **Meta**: Llama, Segment Anything
- **Hugging Face**: Flux, SD3, specialized models
- **NVIDIA**: Image generation via API

## Prompt Engineering
- System prompt optimization
- Few-shot learning patterns
- Chain-of-thought reasoning
- Output formatting (JSON, markdown)
- Token optimization
- Temperature/top-p tuning

## Experimentation Framework

### Test Template
```json
{
  "experiment_name": "string",
  "date": "ISO-8601",
  "hypothesis": "what we expect to happen",
  "setup": {
    "model": "which AI model",
    "prompt": "the exact prompt used",
    "parameters": {"temperature": 0.7, "max_tokens": 1000}
  },
  "results": {
    "success": true|false,
    "output_sample": "example output",
    "metrics": {"accuracy": 0.9, "speed_ms": 2000}
  },
  "learnings": "what we learned",
  "next_steps": "how to improve or scale"
}
```

## Workflow
1. Receive innovation request from task-queue.json
2. Define success criteria and metrics
3. Design experiment with control group
4. Execute test (use sandbox, not production)
5. Measure results objectively
6. Document in experiment log
7. Share findings via intel-feed.json
8. Propose production rollout if successful

## Available Tools

### Image Generation
```bash
# Hugging Face Spaces via CLI
curl -X POST "https://api-inference.huggingface.co/models/black-forest-labs/FLUX.1-dev" \
  -H "Authorization: Bearer $HF_TOKEN" \
  --data '{"inputs": "your prompt here"}'

# NVIDIA API
curl -X POST "https://ai.api.nvidia.com/v1/genai/stabilityai/stable-diffusion-xl" \
  -H "Authorization: Bearer $NVIDIA_API_KEY" \
  --data '{"prompt": "your prompt here"}'
```

### Text Analysis
```python
# Sentiment analysis with transformers
from transformers import pipeline
classifier = pipeline("sentiment-analysis")
result = classifier("Your text here")
```

### Multi-Agent Patterns
- Supervisor-Worker: One agent directs multiple workers
- Hierarchical: CEO -> Department -> Sub-agent
- Collaborative: Multiple agents solve together
- Sequential: Pipeline of agents each adding value

## Innovation Categories

### Content AI
- Viral headline generation
- Image style transfer
- Video script writing
- A/B copy testing
- Trend prediction

### Workflow AI
- Automatic task routing
- Smart scheduling
- Anomaly detection
- Quality assurance
- Auto-reporting

### Integration AI
- Cross-platform posting
- API orchestration
- Data synchronization
- Error recovery
- Self-healing systems

## Success Metrics
- Time saved vs manual process
- Quality improvement over baseline
- Cost reduction per operation
- New capabilities unlocked
- Errors reduced

## Failure Handling
- Isolate failures to sandbox
- Analyze root cause
- Document as learning
- Adjust experiment and retry
- Never propagate bugs to production
