import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import HIGTokensSemantic
import SwiftUI

/// Optional admin-density theme inspired by Remark Admin Template color roles.
///
/// Maps Remark-style primary blue and cool page surfaces onto HIG semantic tokens.
/// Components still follow Apple HIG structure; consumers opt in via ``HIGThemeableView``.
public struct HIGAdminTheme: HIGTheme, Sendable {
    public let name: String
    public let colors: any HIGColorSemanticTokens
    public let typography: any HIGTypographySemanticTokens
    public let spacing: any HIGSpacingSemanticTokens
    public let opacity: any HIGOpacitySemanticTokens
    public let border: any HIGBorderSemanticTokens
    public let motion: any HIGMotionSemanticTokens
    public let divider: any HIGDividerTokens
    public let button: any HIGButtonTokens
    public let buttonGroup: any HIGButtonGroupTokens
    public let menuToggle: any HIGMenuToggleTokens
    public let textField: any HIGTextFieldTokens
    public let inputGroup: any HIGInputGroupTokens
    public let fieldMessage: any HIGFieldMessageTokens
    public let datePicker: any HIGDatePickerTokens
    public let timePicker: any HIGDatePickerTokens
    public let select: any HIGSelectTokens
    public let autocomplete: any HIGSelectTokens
    public let tagInput: any HIGSelectTokens
    public let dropZone: any HIGDropZoneTokens
    public let toggle: any HIGToggleTokens
    public let checkbox: any HIGCheckboxTokens
    public let radio: any HIGRadioTokens
    public let segmentedControl: any HIGSegmentedControlTokens
    public let slider: any HIGSliderTokens
    public let picker: any HIGPickerTokens
    public let card: any HIGCardTokens
    public let panel: any HIGPanelTokens
    public let panelGroup: any HIGPanelGroupTokens
    public let counter: any HIGCounterTokens
    public let widget: any HIGWidgetTokens
    public let rating: any HIGRatingTokens
    public let testimonial: any HIGTestimonialTokens
    public let ribbon: any HIGRibbonTokens
    public let pricingCard: any HIGPricingCardTokens
    public let chatBubble: any HIGChatBubbleTokens
    public let comment: any HIGCommentTokens
    public let dataTable: any HIGDataTableTokens
    public let breadcrumb: any HIGBreadcrumbTokens
    public let pageHeader: any HIGPageHeaderTokens
    public let pagination: any HIGPaginationTokens
    public let tabs: any HIGTabsTokens
    public let accordion: any HIGAccordionTokens
    public let steps: any HIGStepsTokens
    public let pearlSteps: any HIGPearlStepsTokens
    public let timeline: any HIGTimelineTokens
    public let statusIndicator: any HIGStatusIndicatorTokens
    public let emptyState: any HIGEmptyStateTokens
    public let closeButton: any HIGCloseButtonTokens
    public let modal: any HIGModalTokens
    public let tooltip: any HIGTooltipTokens
    public let popover: any HIGPopoverTokens
    public let drawer: any HIGDrawerTokens
    public let networkProgressBar: any HIGNetworkProgressBarTokens
    public let progress: any HIGProgressTokens
    public let alert: any HIGAlertTokens
    public let toast: any HIGToastTokens
    public let badge: any HIGBadgeTokens
    public let icon: any HIGIconTokens
    public let avatar: any HIGAvatarTokens
    public let link: any HIGLinkTokens
    public let bulletList: any HIGBulletListTokens
    public let textEditor: any HIGTextEditorTokens
    public let stepper: any HIGStepperTokens
    public let menuButton: any HIGMenuButtonTokens
    public let tag: any HIGTagTokens
    public let navigationBar: any HIGNavigationBarTokens
    public let toolbar: any HIGToolbarTokens
    public let activityIndicator: any HIGActivityIndicatorTokens
    public let matrixLoader: any HIGMatrixLoaderTokens
    public let shimmer: any HIGShimmerTokens
    public let list: any HIGListTokens
    public let sidebar: any HIGSidebarTokens
    public let adminShell: any HIGAdminShellTokens
    public let codeBlock: any HIGCodeBlockTokens
    public let carousel: any HIGCarouselTokens
    public let lightbox: any HIGLightboxTokens
    public let mediaRow: any HIGMediaRowTokens
    public let hero: any HIGHeroTokens
    public let listGroup: any HIGListGroupTokens
    public let barChart: any HIGBarChartTokens
    public let lineChart: any HIGLineChartTokens
    public let pieChart: any HIGPieChartTokens
    public let areaChart: any HIGAreaChartTokens
    public let photoPicker: any HIGPhotoPickerTokens
    public let photoEditor: any HIGPhotoEditorTokens
    public let longTextEditor: any HIGLongTextEditorTokens

    /// Creates an admin theme.
    /// - Parameters:
    ///   - name: Theme display name.
    ///   - hue: Primary hue inspired by Remark skins (default blue primary-600).
    ///   - base: Token baseline; component metrics inherit unless overridden for density.
    public init(
        name: String = "Admin",
        hue: HIGAdminThemeHue = .blue,
        base: HIGSystemTheme = HIGSystemTheme()
    ) {
        let baseColors = base.colors
        self.name = name
        self.colors = HIGSystemColorSemanticTokens(
            labelPrimary: baseColors.labelPrimary,
            labelSecondary: baseColors.labelSecondary,
            labelOnAccent: Color.white,
            backgroundPrimary: HIGAdminPalette.pageBackground,
            backgroundSecondary: HIGAdminPalette.panelBackground,
            fillPrimary: HIGAdminPalette.fill,
            separator: HIGAdminPalette.separator,
            accent: hue.accentColor,
            destructive: HIGAdminPalette.danger,
            warning: HIGAdminPalette.warning
        )
        self.typography = base.typography
        // Slightly denser vertical rhythm for admin dashboards while staying on the 4pt grid.
        self.spacing = HIGSystemSpacingSemanticTokens(
            screenEdge: HIGSpacing.md.rawValue,
            section: HIGSpacing.lg.rawValue,
            item: HIGSpacing.sm.rawValue,
            compactItem: HIGSpacing.xs.rawValue
        )
        self.opacity = base.opacity
        self.border = base.border
        self.motion = base.motion
        self.divider = base.divider
        self.button = base.button
        self.buttonGroup = HIGSystemButtonGroupTokens(spacing: HIGSpacing.xs.rawValue)
        self.menuToggle = base.menuToggle
        self.textField = base.textField
        self.inputGroup = base.inputGroup
        self.fieldMessage = base.fieldMessage
        self.datePicker = base.datePicker
        self.timePicker = base.timePicker
        self.select = base.select
        self.autocomplete = base.autocomplete
        self.tagInput = base.tagInput
        self.dropZone = base.dropZone
        self.toggle = base.toggle
        self.checkbox = base.checkbox
        self.radio = base.radio
        self.segmentedControl = base.segmentedControl
        self.slider = base.slider
        self.picker = base.picker
        self.card = HIGSystemCardTokens(
            cornerRadius: HIGRadius.md.rawValue,
            contentPadding: HIGSpacing.md.rawValue,
            borderWidth: base.card.borderWidth
        )
        self.panel = HIGSystemPanelTokens(
            cornerRadius: HIGRadius.md.rawValue,
            contentPadding: HIGSpacing.md.rawValue,
            headerSpacing: HIGSpacing.xs.rawValue,
            borderWidth: base.panel.borderWidth,
            actionIconPointSize: base.panel.actionIconPointSize,
            minActionTarget: base.panel.minActionTarget,
            titleFont: base.panel.titleFont,
            descriptionFont: base.panel.descriptionFont
        )
        self.panelGroup = base.panelGroup
        self.counter = base.counter
        self.widget = base.widget
        self.rating = base.rating
        self.testimonial = base.testimonial
        self.ribbon = base.ribbon
        self.pricingCard = base.pricingCard
        self.chatBubble = base.chatBubble
        self.comment = base.comment
        self.dataTable = base.dataTable
        self.breadcrumb = HIGSystemBreadcrumbTokens(
            font: base.breadcrumb.font,
            currentFont: base.breadcrumb.currentFont,
            itemSpacing: HIGSpacing.xxs.rawValue,
            separatorPointSize: base.breadcrumb.separatorPointSize,
            minTapTarget: base.breadcrumb.minTapTarget
        )
        self.pageHeader = HIGSystemPageHeaderTokens(
            titleFont: base.pageHeader.titleFont,
            subtitleFont: base.pageHeader.subtitleFont,
            stackSpacing: HIGSpacing.xs.rawValue,
            breadcrumbSpacing: HIGSpacing.sm.rawValue
        )
        self.pagination = base.pagination
        self.tabs = HIGSystemTabsTokens(
            font: base.tabs.font,
            selectedFont: base.tabs.selectedFont,
            itemSpacing: HIGSpacing.md.rawValue,
            underlineHeight: base.tabs.underlineHeight,
            minTapTarget: base.tabs.minTapTarget
        )
        self.accordion = HIGSystemAccordionTokens(
            titleFont: base.accordion.titleFont,
            contentFont: base.accordion.contentFont,
            headerMinHeight: base.accordion.headerMinHeight,
            contentPadding: HIGSpacing.sm.rawValue,
            sectionSpacing: HIGSpacing.xs.rawValue,
            cornerRadius: HIGRadius.sm.rawValue,
            borderWidth: base.accordion.borderWidth,
            chevronPointSize: base.accordion.chevronPointSize
        )
        self.steps = HIGSystemStepsTokens(
            titleFont: base.steps.titleFont,
            detailFont: base.steps.detailFont,
            indexFont: base.steps.indexFont,
            indicatorSize: base.steps.indicatorSize,
            connectorThickness: base.steps.connectorThickness,
            itemSpacing: HIGSpacing.xs.rawValue,
            labelSpacing: HIGSpacing.xxs.rawValue,
            minTapTarget: base.steps.minTapTarget
        )
        self.pearlSteps = HIGSystemPearlStepsTokens(
            pearlSize: base.pearlSteps.pearlSize,
            currentPearlSize: base.pearlSteps.currentPearlSize,
            connectorThickness: base.pearlSteps.connectorThickness,
            itemSpacing: HIGSpacing.xs.rawValue,
            minTapTarget: base.pearlSteps.minTapTarget
        )
        self.timeline = HIGSystemTimelineTokens(
            titleFont: base.timeline.titleFont,
            detailFont: base.timeline.detailFont,
            timestampFont: base.timeline.timestampFont,
            markerSize: base.timeline.markerSize,
            markerIconPointSize: base.timeline.markerIconPointSize,
            connectorWidth: base.timeline.connectorWidth,
            itemSpacing: HIGSpacing.sm.rawValue,
            labelSpacing: HIGSpacing.xxs.rawValue,
            contentLeadingPadding: HIGSpacing.sm.rawValue
        )
        self.statusIndicator = base.statusIndicator
        self.emptyState = HIGSystemEmptyStateTokens(
            iconPointSize: base.emptyState.iconPointSize,
            titleFont: base.emptyState.titleFont,
            messageFont: base.emptyState.messageFont,
            stackSpacing: HIGSpacing.sm.rawValue,
            actionSpacing: HIGSpacing.xs.rawValue,
            maxContentWidth: base.emptyState.maxContentWidth
        )
        self.closeButton = base.closeButton
        self.modal = HIGSystemModalTokens(
            cornerRadius: HIGRadius.md.rawValue,
            contentPadding: HIGSpacing.md.rawValue,
            headerSpacing: HIGSpacing.xs.rawValue,
            borderWidth: base.modal.borderWidth,
            maxWidth: base.modal.maxWidth,
            titleFont: base.modal.titleFont,
            messageFont: base.modal.messageFont
        )
        self.tooltip = base.tooltip
        self.popover = HIGSystemPopoverTokens(
            contentPadding: HIGSpacing.sm.rawValue,
            cornerRadius: HIGRadius.sm.rawValue,
            borderWidth: base.popover.borderWidth,
            maxWidth: base.popover.maxWidth
        )
        self.drawer = HIGSystemDrawerTokens(
            width: 300,
            contentPadding: HIGSpacing.md.rawValue,
            headerSpacing: HIGSpacing.xs.rawValue,
            borderWidth: base.drawer.borderWidth,
            cornerRadius: HIGRadius.sm.rawValue,
            scrimOpacity: base.drawer.scrimOpacity,
            titleFont: base.drawer.titleFont
        )
        self.networkProgressBar = base.networkProgressBar
        self.progress = base.progress
        self.alert = base.alert
        self.toast = base.toast
        self.badge = base.badge
        self.icon = base.icon
        self.avatar = base.avatar
        self.link = base.link
        self.bulletList = base.bulletList
        self.textEditor = base.textEditor
        self.stepper = base.stepper
        self.menuButton = base.menuButton
        self.tag = base.tag
        self.navigationBar = base.navigationBar
        self.toolbar = base.toolbar
        self.activityIndicator = base.activityIndicator
        self.matrixLoader = base.matrixLoader
        self.shimmer = base.shimmer
        self.list = base.list
        self.sidebar = base.sidebar
        self.adminShell = base.adminShell
        self.codeBlock = base.codeBlock
        self.carousel = base.carousel
        self.lightbox = base.lightbox
        self.mediaRow = base.mediaRow
        self.hero = base.hero
        self.listGroup = base.listGroup
        self.barChart = base.barChart
        self.lineChart = base.lineChart
        self.pieChart = base.pieChart
        self.areaChart = base.areaChart
        self.photoPicker = base.photoPicker
        self.photoEditor = base.photoEditor
        self.longTextEditor = base.longTextEditor
    }
}

/// Remark-inspired primary hue keys for ``HIGAdminTheme``.
public enum HIGAdminThemeHue: String, Sendable, CaseIterable, Equatable {
    case blue
    case cyan
    case purple
    case indigo
    case red
    case green

    /// Primary accent color for this hue skin.
    public var accentColor: Color {
        switch self {
        case .blue:
            HIGAdminPalette.bluePrimary
        case .cyan:
            HIGAdminPalette.cyanPrimary
        case .purple:
            HIGAdminPalette.purplePrimary
        case .indigo:
            HIGAdminPalette.indigoPrimary
        case .red:
            HIGAdminPalette.redPrimary
        case .green:
            HIGAdminPalette.greenPrimary
        }
    }
}

/// Palette values inspired by Remark classic tokens (theme module only — not used in components).
enum HIGAdminPalette {
    // Remark blue-600 #3e8ef7
    static let bluePrimary = Color(red: 62 / 255, green: 142 / 255, blue: 247 / 255)
    // cyan-600 #0bb2d4
    static let cyanPrimary = Color(red: 11 / 255, green: 178 / 255, blue: 212 / 255)
    // purple-600 #9463f7
    static let purplePrimary = Color(red: 148 / 255, green: 99 / 255, blue: 247 / 255)
    // indigo-600 #667afa
    static let indigoPrimary = Color(red: 102 / 255, green: 122 / 255, blue: 250 / 255)
    // red-600 #ff4c52
    static let redPrimary = Color(red: 255 / 255, green: 76 / 255, blue: 82 / 255)
    // green / success-600 #11c26d
    static let greenPrimary = Color(red: 17 / 255, green: 194 / 255, blue: 109 / 255)
    // page bg #f1f4f5
    static let pageBackground = Color(red: 241 / 255, green: 244 / 255, blue: 245 / 255)
    // panel / white surface
    static let panelBackground = Color.white
    // blue-grey-ish fill
    static let fill = Color(red: 228 / 255, green: 234 / 255, blue: 236 / 255)
    // gray border #e4eaec
    static let separator = Color(red: 228 / 255, green: 234 / 255, blue: 236 / 255)
    static let danger = Color(red: 255 / 255, green: 76 / 255, blue: 82 / 255)
    static let warning = Color(red: 235 / 255, green: 153 / 255, blue: 38 / 255)
}
