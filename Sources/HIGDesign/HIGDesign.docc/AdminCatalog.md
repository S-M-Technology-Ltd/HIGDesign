# Admin Catalog

HIGDesign v1.5.0 completes the Remark Admin Template **capability** port as HIG-native SwiftUI. Remark is a checklist, not a pixel target — Apple Human Interface Guidelines remain the visual source of truth.

## Themes

Use the optional admin-density theme for denser chrome and Remark-inspired primary hues:

```swift
HIGThemeableView(theme: HIGAdminTheme(hue: .blue)) {
    ContentView()
}
```

Built-in themes also include ``HIGSystemTheme``, ``HIGHighContrastTheme``, and ``HIGBrandTheme``.

## Shell

Compose multi-column admin apps with ``HIGAdminShell``:

```swift
HIGAdminShell(
    style: .sidebar,
    brandTitle: "Acme Admin",
    sidebarTitle: "Menu",
    selection: $section,
    items: items
) { section in
    HIGPageHeader("Dashboard", subtitle: "Overview")
    // panels, tables, charts…
}
```

Styles: `.sidebar`, `.iconRail`, `.topBar`, `.topIcon`, `.centered`, `.drawer`.

## Surfaces & data

| Need | API |
|------|-----|
| Content chrome | ``HIGPanel``, ``HIGPanelGroup``, ``HIGWidget`` |
| Wayfinding | ``HIGBreadcrumb``, ``HIGPageHeader``, ``HIGTabs``, ``HIGPagination`` |
| Process | ``HIGSteps``, ``HIGPearlSteps``, ``HIGTimeline`` |
| Tables | ``HIGDataTable`` |
| Hierarchy | ``HIGTreeView``, ``HIGReorderableList`` |
| Dashboard layout | ``HIGDashboardGrid``, ``HIGCounter`` |
| Charts | ``HIGBarChart``, ``HIGLineChart``, ``HIGPieChart``, ``HIGAreaChart`` |

## Forms

Advanced form chrome ships as ``HIGInputGroup``, ``HIGFieldMessage``, ``HIGDatePicker``, ``HIGTimePicker``, ``HIGSelect``, ``HIGAutocomplete``, ``HIGTagInput``, and ``HIGDropZone``.

## Recipes (Showcase only)

Apps and pages from the Remark HTML demos are **Showcase compositions**, not library business modules:

- **Map** — MapKit + `HIGWidget` / `HIGPanel` (no `HIGMap` type)
- **13 app recipes** — mailbox, calendar, contacts, documents, forum, location, media, message, notebook, projects, taskboard, travel, work
- **17 page recipes** — login/register/profile/error/email variants consolidated

Browse them in `HIGShowcaseApp` / `HIGDesignSample`. Tracker: `Docs/ADMIN_TEMPLATE_PORT.md`.

## Related

- <doc:Components>
- <doc:CustomThemes>
- <doc:ShowcaseApp>
- <doc:GettingStarted>
