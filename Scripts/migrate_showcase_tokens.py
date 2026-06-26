#!/usr/bin/env python3
"""Migrate Showcase Swift files from hardcoded layout literals to theme tokens."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SHOWCASE_DIR = ROOT / "Showcase"

REPLACEMENTS = [
    (".font(.caption.monospaced())", ".font(theme.typography.caption.monospaced())"),
    (".font(.caption.weight(.semibold))", ".font(theme.typography.caption.weight(.semibold))"),
    (".font(.headline)", ".font(theme.typography.headline)"),
    (".font(.caption)", ".font(theme.typography.caption)"),
    (".font(.body)", ".font(theme.typography.body)"),
    (".font(.title2)", ".font(theme.typography.title)"),
    ("spacing: 24", "spacing: theme.spacing.section"),
    ("spacing: 20", "spacing: theme.spacing.section"),
    ("spacing: 16", "spacing: theme.spacing.screenEdge"),
    ("spacing: 12", "spacing: theme.spacing.item"),
    ("spacing: 8", "spacing: theme.spacing.compactItem"),
    ("spacing: 4", "spacing: HIGSpacing.xxs.rawValue"),
    ("spacing: 2", "spacing: HIGSpacing.xxs.rawValue / 2"),
    ("spacing: 0", "spacing: HIGSpacing.none.rawValue"),
    (".padding(.horizontal, 16)", ".padding(.horizontal, theme.spacing.screenEdge)"),
    (".padding(.top, 12)", ".padding(.top, theme.spacing.item)"),
    (".foregroundStyle(.secondary)", ".foregroundStyle(theme.colors.labelSecondary)"),
]

ENV_LINE = "    @Environment(\\.higTheme) private var theme\n"
THEME_ENV_MARKER = "@Environment(\\.higTheme)"


def needs_hig_design_import(text: str) -> bool:
    return "theme." in text or "HIGSpacing." in text or "higPadding" in text or "HIGDesign" in text


def ensure_imports(text: str) -> str:
    if "import HIGDesign" in text:
        return text
    if needs_hig_design_import(text):
        if "import SwiftUI" in text:
            return text.replace("import SwiftUI\n", "import HIGDesign\nimport SwiftUI\n", 1)
        return "import HIGDesign\n" + text
    return text


def ensure_theme_environment(text: str) -> str:
    if THEME_ENV_MARKER in text:
        return text

    if "struct " not in text or ": View" not in text:
        return text

    if "theme." not in text and "HIGSpacing." not in text:
        return text

    pattern = re.compile(r"(struct\s+\w+[^{]*:\s*View[^{]*\{)\n")
    match = pattern.search(text)
    if not match:
        return text

    insert_at = match.end()
    return text[:insert_at] + ENV_LINE + text[insert_at:]


def migrate_file(path: Path) -> bool:
    original = path.read_text(encoding="utf-8")
    updated = original

    for old, new in REPLACEMENTS:
        updated = updated.replace(old, new)

    updated = ensure_imports(updated)
    updated = ensure_theme_environment(updated)

    if updated != original:
        path.write_text(updated, encoding="utf-8")
        return True
    return False


def main() -> int:
    changed = 0
    for path in sorted(SHOWCASE_DIR.rglob("*.swift")):
        if migrate_file(path):
            changed += 1
            print(f"updated {path.relative_to(ROOT)}")
    print(f"Migrated {changed} files.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())