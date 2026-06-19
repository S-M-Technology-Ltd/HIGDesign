#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

PATTERN='DispatchQueue|dispatch_async|dispatch_sync|dispatch_get_main_queue|DispatchGroup|DispatchSemaphore|DispatchWorkItem|DispatchSource|DispatchSpecificKey|DispatchTime'

if rg -n "$PATTERN" Sources Tests; then
    echo "GCD guard failed: use Swift concurrency (Task, async/await, actors) instead of GCD." >&2
    exit 1
fi

echo "GCD guard passed: no DispatchQueue or dispatch_* APIs in Sources or Tests."