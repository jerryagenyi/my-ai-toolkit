# Cloud GPU Options — Renting What the Local Rig Can't Do

> Companion to [hardware-targets.md](hardware-targets.md). The local rig (RX 6800 XT) has
> no CUDA, which blocks training and diffusion experiments — but CUDA can be **rented by
> the hour** (or used free on Kaggle). This changes the upgrade calculus: buy the 3090 when
> *convenience or regularity* justifies it, not to unlock a one-off experiment.
>
> **Caveat:** prices and free quotas below are order-of-magnitude, checked 2026-10 —
> always verify on the platform before planning a run.

## The principle

**Buy VRAM for what you do daily; rent CUDA for what you do occasionally.**

- Serving models 24/7, low latency, privacy (nothing leaves the box) → local.
- A 3-hour LoRA training run, a ComfyUI image-gen trial, a one-off big-model test →
  rented GPU often costs less than the electricity, and requires no hardware commitment.

## Options compared

| Platform | Typical offer | Cost | Best for | Watch out |
|---|---|---|---|---|
| **Kaggle Notebooks** (kaggle.com → Create) | Free GPU: T4 ×2 or P100; ~30 GPU-h/week quota; ~9–12 h sessions; free CPU/RAM too | Free | First port of call — training trials, LoRA experiments, learning CUDA workflows; datasets host too | Quota resets weekly; session caps force checkpoint/resume; shared-tier performance varies |
| **RunPod** | On-demand pods, any card (3090 → H100); community (cheaper, interruptible) vs secure cloud; persistent volumes; ComfyUI/templates one-click | ~$0.2–0.3/h community 3090; ~$0.5–0.7/h 4090; ~$1.5–2/h A100 | Serious training runs, image/video gen trials, repeatable environments | Community pods can be preempted; delete pods/volumes when done or the meter keeps running |
| **vast.ai** | Marketplace, often cheapest per GPU-h; bring your own image | Often 20–40% under RunPod | Budget bulk runs | More DIY; reliability varies by host |
| **Google Colab** | Free T4; Pro tiers for better cards | Free / ~£10/mo | Quick notebook experiments | Session limits on free tier; notebooks-first |
| **Lightning AI / Modal** | Studio environments / serverless per-second billing | Free tiers, then usage | Different workflows worth knowing exist | Smaller ecosystems |

## Mapping to our blocked experiments

| Experiment (blocked locally by no CUDA) | Where to run it |
|---|---|
| Micro-turn LoRA per Codacus recipe (3 h on 2×3060-class) | **Kaggle first** (free, fits quota); RunPod 4090 for iteration speed |
| ComfyUI / Flux-class image + video gen trials | **RunPod** (one-click ComfyUI template, persistent volume for outputs) |
| 70B-class / big-MoE one-off serving tests | RunPod A100/H100 by the hour — a taste of the 192 GB tier before ever buying it |
| Whistle STT / KittenTTS 2 / Phonon-2 trials | Local CPU or Kaggle — small models |
| ls2 pipeline GPU acceleration (CTranslate2 is CUDA-only) | Local CPU is fine for PoC; Kaggle for benchmarking the GPU path |

## Practice notes

- **Cost sanity check:** Codacus's 3 h × 2× RTX 3060 training ≈ 6 GPU-h ≈ **free on Kaggle**, ~$1.50–2 on a rented 4090. The "I need a 3090 to train" instinct is usually wrong for occasional runs.
- **Data privacy:** ls2 is local-first by design — fine for synthetic/experimental data, think twice before putting real event audio or anything sensitive on a rented box.
- **Reproducibility:** pin images/versions in any pod; keep training scripts in git so a pod is disposable.
- **Hybrid pattern that fits us:** develop and serve locally (Vulkan), rent CUDA only for the training/generation step, bring the artifact (LoRA adapter, images) home.
