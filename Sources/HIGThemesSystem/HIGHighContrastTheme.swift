import HIGThemesContract
import HIGTokensComponent
import HIGTokensSemantic
import SwiftUI

public struct HIGHighContrastTheme: HIGTheme, Sendable {
    public let name = "High Contrast"
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
    public let cover: any HIGCoverTokens
    public let imageOverlay: any HIGImageOverlayTokens
    public let colorSelector: any HIGColorSelectorTokens
    public let socialButton: any HIGSocialButtonTokens
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

    public init(base: HIGSystemTheme = HIGSystemTheme()) {
        let baseColors = base.colors
        self.colors = HIGSystemColorSemanticTokens(
            labelPrimary: baseColors.labelPrimary,
            labelSecondary: baseColors.labelSecondary,
            labelOnAccent: baseColors.labelOnAccent,
            backgroundPrimary: baseColors.backgroundPrimary,
            backgroundSecondary: baseColors.backgroundSecondary,
            fillPrimary: baseColors.fillPrimary,
            separator: baseColors.separator,
            accent: baseColors.accent,
            destructive: Color.red,
            warning: baseColors.warning
        )
        self.typography = base.typography
        self.spacing = base.spacing
        self.opacity = base.opacity
        self.border = base.border
        self.motion = base.motion
        self.divider = base.divider
        self.button = base.button
        self.buttonGroup = base.buttonGroup
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
        self.card = base.card
        self.panel = base.panel
        self.panelGroup = base.panelGroup
        self.counter = base.counter
        self.widget = base.widget
        self.rating = base.rating
        self.testimonial = base.testimonial
        self.ribbon = base.ribbon
        self.pricingCard = base.pricingCard
        self.chatBubble = base.chatBubble
        self.comment = base.comment
        self.cover = base.cover
        self.imageOverlay = base.imageOverlay
        self.colorSelector = base.colorSelector
        self.socialButton = base.socialButton
        self.dataTable = base.dataTable
        self.breadcrumb = base.breadcrumb
        self.pageHeader = base.pageHeader
        self.pagination = base.pagination
        self.tabs = base.tabs
        self.accordion = base.accordion
        self.steps = base.steps
        self.pearlSteps = base.pearlSteps
        self.timeline = base.timeline
        self.statusIndicator = base.statusIndicator
        self.emptyState = base.emptyState
        self.closeButton = base.closeButton
        self.modal = base.modal
        self.tooltip = base.tooltip
        self.popover = base.popover
        self.drawer = base.drawer
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