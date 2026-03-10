#!/usr/bin/env bash
set -euo pipefail

# OpenClaw quick installer wrapper (macOS/Linux)
# - Preflight (Node >= 22)
# - Calls official installer
# - Runs onboarding + basic health checks

say() { printf "\n[%s] %s\n" "$(date +'%F %T')" "$*"; }

say "Preflight: OS"
uname -a || true

if ! command -v curl >/dev/null 2>&1; then
  say "ERROR: curl not found. Please install curl first." >&2
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  say "ERROR: Node not found. Install Node >= 22 first." >&2
  exit 2
fi

NODE_MAJOR=$(node -p "process.versions.node.split('.')[0]" 2>/dev/null || echo 0)
if [[ "${NODE_MAJOR}" -lt 22 ]]; then
  say "ERROR: Node version must be >= 22. Current: $(node -v)" >&2
  exit 3
fi

# Network hint (non-blocking)
if [[ -n "${http_proxy:-}" || -n "${https_proxy:-}" ]]; then
  say "Proxy detected: http_proxy/https_proxy are set."
else
  say "No proxy env detected. If installation fails due to network, read docs/proxy.md" 
fi

say "Checking connectivity (best-effort): https://openclaw.ai"
if ! curl -fsSL --max-time 10 https://openclaw.ai >/dev/null; then
  say "WARNING: Cannot reach https://openclaw.ai (network/proxy/DNS issue)." >&2
  say "You can still try, but installation may fail." >&2
fi

say "Running official installer"
# Keep it simple and transparent: call official installer.
curl -fsSL https://openclaw.ai/install.sh | bash

say "Post-check: openclaw on PATH"
if ! command -v openclaw >/dev/null 2>&1; then
  say "ERROR: openclaw not found on PATH after install." >&2
  say "Fix PATH (macOS/Linux): export PATH=\"$(npm prefix -g)/bin:$PATH\"" >&2
  exit 4
fi

say "Run onboarding (installs daemon so it keeps running)"
openclaw onboard --install-daemon

say "Health checks"
openclaw doctor || true
openclaw status || true
openclaw health || true

say "Done. Next: openclaw dashboard"
