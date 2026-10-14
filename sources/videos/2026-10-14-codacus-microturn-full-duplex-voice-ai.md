---
id: SRC-VIDEO-CODACUS-MICROTURN-2026
type: youtube
title: "Full-Duplex Voice AI on a Local 35B LLM (Micro-Turns)"
url: https://youtu.be/shJLycXjhVY
captured_at: 2026-10-14
channel: Codacus (local AI builds)
model: Qwen3.6-35B-A3B Q4_K_M + MicroTurn Duplex LoRA (top 4 layers, 3.83M params)
hardware_in_video: 1× RTX 3060 12GB (training: 2× RTX 3060)
status: captured
---

# Codacus — Full-Duplex Voice AI on a Local 35B LLM (Micro-Turns)

> Researched 2026-10-14 from the video page, the Hugging Face adapter card, the DuplexCascade
> paper, and the linked vendor pages. All claims below are sourced; speculation is marked.

## Video metadata

| Field | Value |
|---|---|
| Channel | Codacus (local AI builds) |
| Video | https://youtu.be/shJLycXjhVY |
| Title (page) | "Can a Local LLM Speak and Listen at the Same Time?" — search listings show "35B Text LLM That Listens While It Talks, on One RTX 3060 \| Full Duplex Voice AI" |
| Published | 2026-10-12 (~2K views when researched) |
| Core claim | A normal 35B text model (Qwen3.6-35B-A3B) listens while it talks — full duplex on **one RTX 3060 12GB** with llama.cpp. **No VAD in the loop, no new speech-to-speech model.** |
| Context | Codacus's community post describes this as the behavior he wants "for Lanstreamer 2" (his local voice-assistant build; no public repo found — the name appears only in his channel posts). |

## TL;DR

The trick is **micro-turns**: every 0.6 s, streaming STT hands the LLM the few words you just
said, and the model either emits a few words for TTS or stays silent. Like a CPU core running
two programs — it does one thing at a time but switches fast enough that you stop noticing.
Prompting alone gets part of the way (a chat model is trained to always answer); the rest took
a **LoRA on the top 4 layers** of the 35B MoE — ~3 h on two RTX 3060s, a few hundred synthetic
conversations. The idea comes from the **DuplexCascade** paper (Yang, Fujita & Sudo, SB
Intuitions, arXiv 2603.09180, submitted to Interspeech 2026).

## 1. The landscape: how the big labs do full duplex

The classic voice pipeline (VAD → STT → LLM → TTS) must take turns like a walkie-talkie: VAD
segments your utterance, the LLM answers after you stop, and it can't hear you while it talks.

| System | Who | Approach | Size | Latency | Notes |
|---|---|---|---|---|---|
| **GPT-Live / gpt-live-1** | OpenAI | Brand-new full-duplex voice model; delegates reasoning + tool use to a backend agent | n/a | "smooth interruption handling" | Audio+text only; Live endpoint only; $0.05/min billed per second; knowledge cutoff 2025-07-31; no image input |
| **Interaction model** | Thinking Machines Lab | Interactivity native in the model; two-model system (real-time interaction model + async background model) | TML-Interaction-Small: 276B MoE, 12B active | 0.40 s turn-taking | 200 ms micro-turns; encoder-free early fusion (dMel audio, hMLP image patches, flow-head TTS); FD-bench v1.5 77.8 vs ~39–54 for competitors; research preview |
| **Moshi** | Kyutai | Speech-text foundation model: Mimi codec + dual audio streams (model + user) + "inner monologue" text tokens | 7B Temporal Transformer + small Depth Transformer | ~200 ms practical (theoretical 160 ms) | Weights CC-BY 4.0, code MIT/Apache-2.0; Moshiko/Moshika voices; ~24 GB GPU unquantized (MLX on Apple Silicon, Rust/Candle builds) |
| **PersonaPlex** | NVIDIA | Moshi architecture + Helium LM; hybrid prompting = voice prompt (audio embedding) + text prompt (role) | 7B (personaplex-7b-v1) | ~0.205 s avg | Fine-tuned from Moshi with <5,000 h directed data (Fisher real 1,217 h + synthetic assistant/customer-service 2,250 h; transcripts via Qwen3-32B / GPT-OSS-120B, speech via Chatterbox TTS); best-in-class turn-taking on FullDuplexBench + new ServiceDuplexBench |

Key trade-off the paper quantifies: end-to-end duplex models lose LLM intelligence — on
**VoiceBench**, Moshi scores **29.51** and PersonaPlex **30.59**, while the naive text pipeline
(ASR → Qwen2-7B → TTS) scores **69.66**. DuplexCascade (and Codacus's build) keep the text LLM
and add duplex behavior on top.

## 2. The micro-turn loop (the core idea)

From DuplexCascade (arXiv 2603.09180):

- Streaming ASR runs continuously; partial transcript is flushed into a **micro-turn every
  Δt = 0.6 s** (paper tested 0.3–1.8 s; 1.2 s gave best turn-taking accuracy but higher latency,
  so 0.6 s is the compromise).
- User and system micro-turns are interleaved in the LLM context with `<EOS>` separators.
- Turn-taking is moved **inside the LLM** via special control tokens instead of an external VAD:

| Token | Meaning / system action |
|---|---|
| `<no voice>` | Nothing recognized on this user flush (user silent) |
| `<user is speaking>` | Stay silent |
| `<user finish speak>` | Start the spoken response (content follows) |
| `<user is interrupting>` | Stop generating immediately |
| `<user backchannel>` | User said "mm-hm" — ignore and continue |
| `<user is thinking>` | No action while user processes |
| `<system backchannel>` | Play a pre-synthesized backchannel clip, then `<EOS>` |

**DuplexCascade benchmark results** (the Moshi/VoiceBench figures Codacus cites are from here):

| Model | Avg turn-taking accuracy ↑ | Synthetic TOR (pause handling) ↓ | VoiceBench overall ↑ |
|---|---|---|---|
| DuplexCascade | **0.858** | **0.058** | 65.41 |
| DuplexCascade-β (with system backchannels) | 0.748 | — | 65.81 |
| PersonaPlex | 0.759 | — | 30.59 |
| MiniCPM-Duplex | 0.598 | — | — |
| Freeze-Omni | 0.489 | — | 55.20 |
| dGSLM | 0.466 | — | — |
| Moshi | 0.395 | 0.985 | 29.51 |
| Text-LLM pipeline (DSM-ASR + Qwen2-7B) | — | — | 69.66 |

## 3. The build (runtime rig)

| Slot | Model | Notes |
|---|---|---|
| LLM (serving) | Qwen3.6-35B-A3B, Q4_K_M GGUF (unsloth) + Codacus's micro-turn LoRA | llama.cpp; fits 12 GB via `--n-cpu-moe 24` (keeps 24 layers' experts in system RAM). Median tick response **~230 ms** |
| STT | Kyutai STT | Streaming, ~0.5 s delay, built-in **semantic VAD** (Kyutai = Moshi lab; CC-BY-4.0; ~1B en/fr or 2.6B en, delayed-streams modeling) |
| TTS | IndexTTS (Bilibili) | Zero-shot voice cloning from one reference clip; v2.5 is 0.8B, 5 languages, separate timbre/emotion control |
| Training | two RTX 3060 12GB | ~3 h total |

Client protocol quirks (from the HF card — these are the "gotchas" if you reproduce it):

- Requires the **exact system prompt** (voice-assistant with 0.6 s transcript ticks).
- Sends **raw chat-template history** to llama.cpp's `/completion` endpoint, not `/chat/completions`.
- Speak-or-listen decoding rule: read the probability of `<` (start of `<listen>`) on the first
  token of each tick. If P(`<`) ≥ 0.3 → listen; otherwise **ban `<` via logit_bias** so the model
  commits to speaking. This is the chapter-12:59 "73% sure" fix — the model kept stopping three
  words into a sentence because it was only ~70% confident it should still be talking; once the
  first token committed to speech, silence is disallowed for the tick.

## 4. Why a prompt is not enough + the training process

A chat model is trained to always answer — it can't emit "no output" naturally, and prompting
alone can't teach per-0.6-s speak/listen discipline. So: LoRA fine-tune.

**Codacus's training recipe** (5th run; earlier runs broke in instructive ways):

| Aspect | Detail |
|---|---|
| Adapter | LoRA **rank 32, α 64** → 3.83 M trainable params (15 MB, F32) — Apache-2.0 |
| What is trained | **Only the top 4 layers (36–39)** of the 40-layer model: three delta-net layers + one full-attention layer. Everything below untouched → learns "timing" without losing knowledge |
| Frozen-layer trick | Lower 36 layers' outputs are **precomputed with llama.cpp and cached**; only layers 36–39 are trained in PyTorch, initialized from the same GGUF weights. Reimplementation verified against llama.cpp at cosine similarity 0.9996 |
| Dataset | **564 synthetic phone calls** (28 held out) written by local LLMs, timed into 0.6 s ticks with ASR-style noise; no real recordings. (10 dialogues / 25 derived calls were removed from the *published* dataset after a safety audit — the adapter was trained before that removal) |
| Loss | **Weighted cross-entropy** — ~75% of ticks are `<listen>`, so unweighted training collapses to always-silent |
| Optimization | 282 steps, AdamW lr 2e-4, first 8,000 tokens per call |
| Hardware / time | 2× RTX 3060 12GB, ~3 h |
| Failure history | Run(s) that never stopped talking; filler ("mm-hm") overuse — both traced to **dataset bias** in the synthetic calls; fixed by data rebalancing, not architecture |

**Compare with the paper's recipe**: DuplexCascade used Qwen2-7B-Instruct, LoRA r16 α32 on
query/value projections only + fine-tuned token embeddings (new special tokens) and prediction
head; 50k UltraChat dialogues converted to simulated duplex sequences (user turns 1–7 tokens,
p=0.10 pauses, p=0.30 interruptions, p=0.01 backchannels); 8× H100 for ~5 h, 5k steps.

**Base model — Qwen3.6-35B-A3B** (why it's a good fit): MoE, 35B total / **~3B active** per
token (256 experts, 8 routed + 1 shared) — so a 12 GB card can serve it quantized; 40 hybrid
layers (Gated DeltaNet linear attention + Gated Attention); 262k native context (~1M with
YaRN); Apache-2.0; released 2026-04-15; vision-language with thinking mode and multi-token
prediction for speculative decoding.

## 5. Scoreboard (Codacus's own runs)

| Metric | Result |
|---|---|
| Time to first word | **~3 s** (weakness; Moshi is ~0.25 s) |
| Starts answers at the right moment | 78% (long calls) / 62% (short calls) |
| Interrupts to warn on dangerous plans (e.g. bleach + ammonia) | 6 / 10 on long calls |
| Stops mid-sentence | ≤ 1% (after the decoding fix) |
| Fillers in the right spot | ~35% (1 in 3) |
| Other limits | English only; research demo — not to be relied on for safety advice |

Demos shown uncut: says "mm-hm" while the user talks (backchannel), waits through thinking
pauses, interrupts to warn about mixing bleach and ammonia.

## 6. Associated models — quick reference

| Model | Role | Params | License | Link |
|---|---|---|---|---|
| Qwen3.6-35B-A3B | Base text LLM (MoE, ~3B active) | 35B | Apache-2.0 | [HF: Qwen/Qwen3.6-35B-A3B](https://huggingface.co/Qwen/Qwen3.6-35B-A3B) · [GGUF: unsloth](https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF) |
| Codacus MicroTurn Duplex LoRA | Timing adapter (top 4 layers) | 3.83M | Apache-2.0 | [HF: codacus/Qwen3.6-35B-A3B-MicroTurn-Duplex-LoRA](https://huggingface.co/codacus/Qwen3.6-35B-A3B-MicroTurn-Duplex-LoRA) |
| Kyutai STT | Streaming ASR w/ semantic VAD | ~1B (en/fr) or 2.6B (en) | CC-BY-4.0 (gated on HF) | kyutai/stt-1 family |
| IndexTTS 2.5 | Zero-shot cloning TTS | 0.8B | open (Bilibili) | [GitHub: index-tts](https://github.com/index-tts/index-tts) |
| Moshi | Open full-duplex speech model | 7B | CC-BY-4.0 / MIT | [GitHub: kyutai-labs/moshi](https://github.com/kyutai-labs/moshi) |
| PersonaPlex | Persona-controllable full duplex | 7B | NVIDIA Open Model License | [NVIDIA Research](https://research.nvidia.com/labs/adlr/personaplex) · HF: personaplex-7b-v1 |
| DuplexCascade | Micro-turn paper + code (Qwen2-7B) | 7B | paper CC BY 4.0 | [arXiv 2603.09180](https://arxiv.org/abs/2603.09180) · [GitHub: sbintuisions/DuplexCascade](https://github.com/sbintuisions/DuplexCascade) |
| GPT-Live-1 | Commercial full-duplex voice | n/a | API | [OpenAI docs](https://developers.openai.com/api/docs/models/gpt-live-1) |
| TML Interaction-Small | Research interaction model | 276B MoE (12B active) | preview | [Thinking Machines blog](https://thinkingmachines.ai/blog/interaction-models/) |

## 7. Community follow-on worth knowing

- [custom-duplex-cascade-pt-br](https://github.com/felipepenhorate/custom-duplex-cascade-pt-br) — Brazilian-Portuguese adaptation on Qwen3-4B-Instruct-2507, running the micro-turn protocol on **llama.cpp + faster-whisper + pocket-tts**. Two variants: plain QLoRA SFT (best tag accuracy 98%, but general-capability regression) vs. **self-distillation** (frozen base generates content, QLoRA learns only the timing tags + forward-KL) — preserves 100% of function-calling/general benchmarks. Useful precedent if we ever train a micro-turn adapter for Nigerian-accented English / Pidgin on our ASR stack.

## 8. Relevance to ls2 (brief)

- The micro-turn pattern is directly relevant to live interpretation turn-taking: barge-in,
  backchannels, and "user is thinking" handling without a VAD gate — candidate for the F3
  language-switch / live-loop work if we want interpreter-style overlap behavior.
- Two transferable engineering tricks: (1) **weighted CE loss** for the ~75%-silent class
  imbalance, (2) **freeze + cache lower layers, LoRA only the top few** — big-model tuning on
  12 GB cards by precomputing frozen-layer outputs with llama.cpp.
- The 3 s first-word latency is the weak point vs. real duplex models — a concern for
  interpreter-calibrated responsiveness targets; the paper's numbers show the cascade approach
  keeps intelligence (VoiceBench 65 vs 30) at the cost of startup latency.

## Sources

- Video: https://youtu.be/shJLycXjhVY (description + chapters supplied by Jerry; page metadata fetched)
- LoRA card (primary source for training/protocol details): https://huggingface.co/codacus/Qwen3.6-35B-A3B-MicroTurn-Duplex-LoRA
- DuplexCascade paper: https://arxiv.org/abs/2603.09180 (full HTML read for benchmark tables)
- Thinking Machines — interaction models: https://thinkingmachines.ai/blog/interaction-models/
- OpenAI GPT-Live-1: https://developers.openai.com/api/docs/models/gpt-live-1
- Moshi: https://github.com/kyutai-labs/moshi
- PersonaPlex: https://research.nvidia.com/labs/adlr/personaplex
- IndexTTS: https://github.com/index-tts/index-tts
- Qwen3.6-35B-A3B: https://huggingface.co/Qwen/Qwen3.6-35B-A3B
- PT-BR community fork: https://github.com/felipepenhorate/custom-duplex-cascade-pt-br
