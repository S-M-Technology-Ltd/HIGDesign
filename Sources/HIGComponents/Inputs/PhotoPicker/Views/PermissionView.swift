#if os(iOS)
import HIGThemesContract
import SwiftUI

struct PermissionView: View {
    let status: HIGPhotoAuthorizationStatus
    let localization: any HIGPhotoLocalizationProviding
    let onRequestAccess: () -> Void
    let onManageLimitedAccess: () -> Void
    let onOpenSettings: () -> Void

    @Environment(\.higTheme) private var theme

    private var tokens: any HIGPhotoPickerTokens { theme.photoPicker }

    var body: some View {
        VStack(spacing: tokens.permissionSectionSpacing) {
            Image(systemName: iconName)
                .font(.system(size: tokens.permissionIconSize, weight: .light))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(theme.colors.labelSecondary)
                .accessibilityHidden(true)

            VStack(spacing: tokens.permissionItemSpacing) {
                Text(title)
                    .font(.title2.weight(.semibold))
                    .multilineTextAlignment(.center)

                Text(message)
                    .font(.body)
                    .foregroundStyle(theme.colors.labelSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, tokens.permissionHorizontalPadding)

            actionButtons
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(tokens.chromeBackground)
    }

    @ViewBuilder
    private var actionButtons: some View {
        switch status {
        case .limited:
            VStack(spacing: tokens.albumListRowSpacing) {
                Button(localization.pickerAddingImageAccessButtonText()) {
                    onManageLimitedAccess()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)

                Button(localization.permissionOpenSettingsButtonText()) {
                    onOpenSettings()
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        case .denied, .restricted:
            Button(localization.permissionOpenSettingsButtonText()) {
                onOpenSettings()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        case .notDetermined:
            Button(localization.permissionRequestAccessButtonText()) {
                onRequestAccess()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        default:
            EmptyView()
        }
    }

    private var iconName: String {
        switch status {
        case .denied, .restricted: return "photo.on.rectangle.angled"
        case .limited: return "photo.badge.plus"
        default: return "photo.on.rectangle"
        }
    }

    private var title: String {
        switch status {
        case .denied: return localization.permissionDeniedTitle()
        case .restricted: return localization.permissionRestrictedTitle()
        case .limited: return localization.photosLimitedAccessTitle()
        case .notDetermined: return localization.pickerNavigationTitle()
        default: return localization.pickerNavigationTitle()
        }
    }

    private var message: String {
        switch status {
        case .denied: return localization.permissionDeniedMessage()
        case .restricted: return localization.permissionRestrictedMessage()
        case .limited: return localization.photosLimitedAccessModeText()
        case .notDetermined: return localization.permissionNotDeterminedMessage()
        default: return localization.permissionDeniedMessage()
        }
    }
}

#if DEBUG
#Preview("Not Determined") {
    PermissionView(
        status: .notDetermined,
        localization: HIGPhotoPreviewData.configuration.localizationProvider,
        onRequestAccess: {},
        onManageLimitedAccess: {},
        onOpenSettings: {}
    )
}

#Preview("Denied") {
    PermissionView(
        status: .denied,
        localization: HIGPhotoPreviewData.configuration.localizationProvider,
        onRequestAccess: {},
        onManageLimitedAccess: {},
        onOpenSettings: {}
    )
}

#Preview("Limited") {
    PermissionView(
        status: .limited,
        localization: HIGPhotoPreviewData.configuration.localizationProvider,
        onRequestAccess: {},
        onManageLimitedAccess: {},
        onOpenSettings: {}
    )
}

#Preview("Restricted") {
    PermissionView(
        status: .restricted,
        localization: HIGPhotoPreviewData.configuration.localizationProvider,
        onRequestAccess: {},
        onManageLimitedAccess: {},
        onOpenSettings: {}
    )
}
#endif
#endif