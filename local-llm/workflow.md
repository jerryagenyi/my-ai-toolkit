# Local LLM — Using the API

The server exposes an OpenAI-compatible API. Any tool that supports OpenAI works with it — just change the base URL.

**Base URL:** `http://localhost:8033/v1`  
**From Tailnet:** `http://100.102.126.128:8033/v1`  
**Auth:** none required (local server)

---

## Chat via curl

```bash
curl http://localhost:8033/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "local",
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": "Explain this Python code: print(x for x in range(10))"}
    ],
    "max_tokens": 500,
    "temperature": 0.7
  }'
```

---

## Python (requests)

```python
import requests

response = requests.post("http://localhost:8033/v1/chat/completions", json={
    "model": "local",
    "messages": [
        {"role": "user", "content": "Your question here"}
    ],
    "max_tokens": 1000
})
print(response.json()["choices"][0]["message"]["content"])
```

---

## Python (openai SDK — drop-in replacement)

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:8033/v1",
    api_key="not-needed"  # required by SDK but ignored by local server
)

response = client.chat.completions.create(
    model="local",
    messages=[{"role": "user", "content": "Hello"}]
)
print(response.choices[0].message.content)
```

---

## Hermes agent integration

In the Hermes agent's `.env` file (e.g. `/home/cih/.hermes/.env` on the VPS, or your local Hermes):

```bash
OPENAI_BASE_URL=http://100.102.126.128:8033/v1
OPENAI_API_KEY=not-needed
```

Or in `config.yaml`:

```yaml
llm:
  provider: openai
  model: local
  base_url: http://100.102.126.128:8033/v1
  api_key: not-needed
```

The Tailscale address `100.102.126.128` means any Hermes agent on your Tailnet (VPS, Kali, WSL) can reach your local model over the private network.

**Firewall must be open first** — see `quickstart.md` Step 5.

---

## Streaming responses

Add `"stream": true` to get token-by-token output (faster perceived response):

```bash
curl http://localhost:8033/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"local","messages":[{"role":"user","content":"Tell me a story"}],"stream":true}'
```

---

## Model performance reference

| Model | Context | Speed (est.) | Use case |
|-------|---------|-------------|----------|
| Qwen3-14B Q4_K_M | 32K | ~50-60 tok/s | Fast, daily use |
| Qwen3-30B-A3B Q4_K_M | 128K | ~40-50 tok/s | Complex tasks, longer context |

Speed tested on: RX 6800 XT 16 GB + Ryzen 7 5800X + 64 GB RAM

---

## Thinking mode (Qwen3 feature)

Qwen3 models support a `/think` and `/no_think` toggle in the system prompt or via a special flag. For complex tasks like security analysis or multi-step reasoning:

```json
{
  "model": "local",
  "messages": [
    {"role": "system", "content": "You are a helpful assistant. /think"},
    {"role": "user", "content": "Analyze this network traffic pattern..."}
  ]
}
```

`/think` enables chain-of-thought reasoning (slower but more accurate for hard problems).  
`/no_think` disables it (faster, better for simple Q&A).
