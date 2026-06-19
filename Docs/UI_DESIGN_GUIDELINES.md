# HIGDesign UI Design Guidelines

## Purpose

This document makes Apple Human Interface Guidelines review a permanent standard for HIGDesign public API work. It is a rule map for components, modifiers, themes, and Showcase content across iOS, iPadOS, macOS, visionOS, tvOS, and watchOS.

Every new or changed public component, modifier, or themed visual must be reviewed against this document before a PR is opened or marked ready.

Xcode preview and view-naming rules live in [`XCODE_PREVIEWS.md`](XCODE_PREVIEWS.md).

## Mandatory Apple HIG Rule

HIGDesign is an Apple-only design system. Public UI must follow Apple Human Interface Guidelines, use native SwiftUI patterns first, and adapt across Apple platforms without web-style or cross-platform layout assumptions.

Custom UI is allowed only when a native SwiftUI control or platform pattern cannot satisfy the HIG requirement. The PR must explain that justification and the accessibility behavior.

## HIG Section Map

Use this map when reviewing public API changes.

### Foundations

Especially important for HIGDesign:

- Accessibility
- Color
- Dark Mode
- Layout
- Materials
- Motion
- SF Symbols
- Typography

Review implications:

- Use system colors and text styles unless a semantic token has a documented HIG mapping.
- Respect light mode, dark mode, Dynamic Type, Reduce Motion, Increase Contrast, and VoiceOver.
- Use SF Symbols for common iconography.
- Keep component labels and accessibility strings concise and specific.

### Components

Especially important for HIGDesign:

- Buttons
- Toggles
- Text fields
- Search fields
- Tab bars
- Sidebars
- Toolbars
- Alerts
- Sheets
- Popovers
- Progress indicators
- Lists and tables

Review implications:

- Public components must map to a HIG component category.
- Destructive actions require clear emphasis and confirmation patterns where applicable.
- Loading and progress states must use native indicators.
- Navigation components must follow platform conventions for tabs, sidebars, and toolbars.

### Patterns

Especially important for HIGDesign:

- Entering data
- Feedback
- Loading
- Modality
- Searching
- Settings
- Undo and redo

Review implications:

- Input components must expose validation-friendly APIs without owning app business rules.
- Empty, loading, and error presentation patterns must be documented in Showcase.
- Modal presentation should use native SwiftUI presentation APIs unless bridging is explicitly justified.

## Platform Review Checklist

### iOS

- Minimum touch targets where HIG requires them
- Safe area awareness
- Dynamic Type scaling

### iPadOS

- Regular width behavior
- Pointer hover where appropriate
- Split-view friendly layouts

### macOS

- Keyboard navigation and focus visibility
- Pointer-friendly spacing
- Useful window and sheet minimum sizes in Showcase

### visionOS

- Depth and ornament-friendly layout choices
- No flat web-style assumptions

### tvOS

- Focus engine support
- No hover-only affordances
- Large, legible component sizing

### watchOS

- Compact layouts only
- No controls that require unsupported precision interactions

## Accessibility Checklist

- Visible label or `accessibilityLabel`
- Correct accessibility traits
- Dynamic Type supported
- Increased contrast supported
- Reduce Motion respected
- VoiceOver reading order is logical

## PR Checklist For UI Changes

- [ ] Relevant `Requirements/*/REQ.md` updated
- [ ] `Docs/UI_DESIGN_GUIDELINES.md` rules considered
- [ ] Same-file `#Preview` added or updated
- [ ] Accessibility behavior described
- [ ] Platform availability documented
- [ ] Showcase example planned or updated