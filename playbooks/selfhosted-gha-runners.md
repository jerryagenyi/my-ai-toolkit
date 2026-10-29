# Playbook — Self-hosted GitHub Actions runners (ja VPS)

**Canonical infra:** `github.com/jerryagenyi/selfhosted-runner` (private) — the
compose file, setup/ops README, PAT handling. This playbook records the decisions;
that repo holds the implementation.

## What & why

- Private-repo CI on our own box: free unlimited minutes, and the runner sits
  inside the Tailnet, so deploy jobs can reach Tailscale-only services that
  GitHub-hosted runners can't.
- Runner = outbound-polling agent on 443. No VM, no inbound ports, no Traefik
  route — a Dokploy compose project on ja is the entire deployment.

## Decisions (2026-10-29)

- **No org (yet)** — personal account means per-repo runner blocks in one
  compose project. If an org is ever created, collapse to a single `ORG_URL`
  block (repo transfer is ~30s, old URLs redirect forever).
- **Image:** `myoung34/docker-github-actions-runner` (community standard),
  `EPHEMERAL: "1"` + `restart` = fresh runner per job. The container exiting
  after every job is by design, not a crash.
- **PAT:** classic, `repo` scope only, lives ONLY as the Dokploy project env
  var `GHA_PAT`. Dokploy's own GitHub integration does not cover this — its
  credentials are internal to Dokploy, not exposed to compose services.
- **Hybrid CI:** default `ubuntu-latest` (2,000 free min/mo on a personal
  account, private repos included); `runs-on: [self-hosted, linux]` only where
  it earns its keep — Tailnet deploys, docker builds, heavy suites.
- **Caps:** 1 CPU / 768MB per runner. ja measured 2026-10-29: 7.8GB RAM,
  ~2.7GB available, swap 4/4GB FULL — recheck `free -h` after first jobs.

## Hard rules

- **Public repos never use these runners.** Fork PRs execute arbitrary
  workflow code on the host, and public repos get free GitHub-hosted minutes
  anyway — self-hosting them buys nothing. (LANStreamer and my-ai-toolkit
  blocks ship disabled in the compose for this reason.)
- Anyone with push access to a registered repo executes code on ja — keep the
  repo list deliberate.
- No `docker.sock` mount unless consciously accepted: the socket is root over
  the same daemon that runs Dokploy and every service on the box.
