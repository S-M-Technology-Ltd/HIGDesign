#!/usr/bin/env bash
# Fail when multi-platform sources use AppKit/UIKit-only APIs outside a matching
# #if os(...) / #if canImport(...) region.
#
# This catches iOS sample build breaks that `swift test` (macOS host) will not see,
# e.g. unguarded `Color(nsColor:)` in Showcase.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

python3 - <<'PY'
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(".").resolve()

SCAN_ROOTS = [
    ROOT / "Showcase",
    ROOT / "Sample",
    ROOT / "Sources" / "HIGComponents",
    ROOT / "Sources" / "HIGModifiers",
    ROOT / "Sources" / "HIGPlatform",
    ROOT / "Sources" / "HIGThemesContract",
    ROOT / "Sources" / "HIGThemesSystem",
    ROOT / "Sources" / "HIGFoundations",
    ROOT / "Sources" / "HIGTokensRaw",
    ROOT / "Sources" / "HIGTokensSemantic",
    ROOT / "Sources" / "HIGTokensComponent",
    ROOT / "Sources" / "HIGIcons",
    ROOT / "Sources" / "HIGDesign",
]

MACOS_ONLY = [
    (re.compile(r"\bColor\s*\(\s*nsColor\s*:"), "Color(nsColor:)"),
    (re.compile(r"\bNSColor\b"), "NSColor"),
    (re.compile(r"\bNSView\b"), "NSView"),
    (re.compile(r"\bNSWindow\b"), "NSWindow"),
    (re.compile(r"\bNSHostingView\b"), "NSHostingView"),
    (re.compile(r"\bNSApplication\b"), "NSApplication"),
    (re.compile(r"\bNSScreen\b"), "NSScreen"),
    (re.compile(r"\bNSImage\b"), "NSImage"),
    (re.compile(r"\bNSBitmapImageRep\b"), "NSBitmapImageRep"),
    (re.compile(r"^\s*import\s+AppKit\b"), "import AppKit"),
]

UIKIT_ONLY = [
    (re.compile(r"\bColor\s*\(\s*uiColor\s*:"), "Color(uiColor:)"),
    (re.compile(r"\bUIColor\b"), "UIColor"),
    (re.compile(r"\bUIView\b"), "UIView"),
    (re.compile(r"\bUIImage\b"), "UIImage"),
    (re.compile(r"\bUIApplication\b"), "UIApplication"),
    (re.compile(r"^\s*import\s+UIKit\b"), "import UIKit"),
]

IF_RE = re.compile(r"^\s*#if\b(.*)$")
ELSEIF_RE = re.compile(r"^\s*#elseif\b(.*)$")
ELSE_RE = re.compile(r"^\s*#else\b")
ENDIF_RE = re.compile(r"^\s*#endif\b")


def grants_appkit(cond: str) -> bool:
    c = cond.strip()
    if re.search(r"canImport\s*\(\s*AppKit\s*\)", c):
        return True
    if re.search(r"\bos\s*\(\s*macOS\s*\)", c):
        return True
    return False


def grants_uikit(cond: str) -> bool:
    c = cond.strip()
    if re.search(r"canImport\s*\(\s*UIKit\s*\)", c):
        return True
    if re.search(r"\bos\s*\(\s*(iOS|tvOS|watchOS|visionOS)\s*\)", c):
        return True
    return False


class RegionStack:
    """Track active #if / #elseif / #else branch conditions."""

    def __init__(self) -> None:
        # Each frame: {"active": condition_string | None for else-without-grant}
        self.frames: list[dict] = []

    def push_if(self, cond: str) -> None:
        self.frames.append({"active": cond.strip(), "seen_grants_appkit": grants_appkit(cond), "seen_grants_uikit": grants_uikit(cond)})

    def push_elseif(self, cond: str) -> None:
        if not self.frames:
            return
        frame = self.frames[-1]
        frame["active"] = cond.strip()
        # elseif replaces active branch
        frame["seen_grants_appkit"] = grants_appkit(cond)
        frame["seen_grants_uikit"] = grants_uikit(cond)

    def push_else(self) -> None:
        if not self.frames:
            return
        # else: active when prior conditions false — do not inherit AppKit/UIKit grants
        self.frames[-1]["active"] = ""
        self.frames[-1]["seen_grants_appkit"] = False
        self.frames[-1]["seen_grants_uikit"] = False

    def pop(self) -> None:
        if self.frames:
            self.frames.pop()

    def allows_appkit(self) -> bool:
        # Line is only compiled when every frame matches; AppKit is available if
        # any active frame's condition grants AppKit (e.g. nested under canImport(AppKit)).
        return any(f.get("seen_grants_appkit") for f in self.frames)

    def allows_uikit(self) -> bool:
        return any(f.get("seen_grants_uikit") for f in self.frames)


def swift_files() -> list[Path]:
    files: list[Path] = []
    for root in SCAN_ROOTS:
        if not root.exists():
            continue
        files.extend(root.rglob("*.swift"))
    # Bridging is allowed to use Cocoa freely.
    return sorted(p for p in files if "Sources/HIGBridging" not in str(p))


def scan(path: Path) -> list[str]:
    out: list[str] = []
    stack = RegionStack()
    try:
        lines = path.read_text(encoding="utf-8").splitlines()
    except OSError as exc:
        return [f"{path}: read error: {exc}"]

    rel = path.relative_to(ROOT)
    for lineno, line in enumerate(lines, start=1):
        if m := IF_RE.match(line):
            stack.push_if(m.group(1))
            continue
        if m := ELSEIF_RE.match(line):
            stack.push_elseif(m.group(1))
            continue
        if ELSE_RE.match(line):
            stack.push_else()
            continue
        if ENDIF_RE.match(line):
            stack.pop()
            continue

        stripped = line.strip()
        if not stripped or stripped.startswith("//"):
            continue

        if not stack.allows_appkit():
            for rx, name in MACOS_ONLY:
                if rx.search(line):
                    out.append(f"{rel}:{lineno}: unguarded {name} (need #if os(macOS) or #if canImport(AppKit))")
        if not stack.allows_uikit():
            for rx, name in UIKIT_ONLY:
                if rx.search(line):
                    out.append(f"{rel}:{lineno}: unguarded {name} (need #if canImport(UIKit) / os(iOS|…))")
    return out


def main() -> int:
    violations: list[str] = []
    for path in swift_files():
        violations.extend(scan(path))

    if violations:
        print("Platform API guard failed.", file=sys.stderr)
        print(
            "Platform-private APIs must sit inside matching #if regions so every "
            "sample destination (iOS + macOS) compiles.",
            file=sys.stderr,
        )
        for v in violations:
            print(f"  {v}", file=sys.stderr)
        print(
            f"\n{len(violations)} violation(s).\n"
            "Fix the guards, then run:\n"
            "  Scripts/verify_platform_api_guards.sh\n"
            "  Scripts/verify_sample_xcode_project.sh",
            file=sys.stderr,
        )
        return 1

    print("Platform API guard passed: multi-platform sources guard AppKit/UIKit APIs.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
PY
