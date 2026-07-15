import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

/// A themed image container with corner radius, border, and aspect presets.
///
/// Use for admin media thumbnails, card images, and gallery tiles. Chrome
/// resolves from ``HIGTheme/imageFrame``. Pair with ``HIGImageOverlay`` for captions.
///
/// Pass **resizable** media (for example `Image(...).resizable()`). The frame
/// applies ``ContentMode/fill`` or ``ContentMode/fit`` and clips overflow so
/// intrinsic bitmap size cannot stretch parent layouts such as grids.
public struct HIGImageFrame<Content: View>: View {
    private let aspect: HIGImageFrameAspect
    private let contentMode: ContentMode
    private let showsBorder: Bool
    private let cornerRadiusOverride: CGFloat?
    private let accessibilityLabelText: String?
    private let content: () -> Content

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    /// Creates an image frame around custom content.
    /// - Parameters:
    ///   - aspect: Aspect ratio preset.
    ///   - contentMode: How content scales inside the frame (default fill + clip).
    ///   - showsBorder: When `false`, omits the themed stroke (for example when a
    ///     parent card already draws chrome).
    ///   - cornerRadius: Optional radius override; `nil` uses ``HIGTheme/imageFrame``.
    ///   - accessibilityLabel: Optional label for VoiceOver when content is decorative.
    ///   - content: Image or media content (for example resizable `Image`, gradient).
    public init(
        aspect: HIGImageFrameAspect = .photo,
        contentMode: ContentMode = .fill,
        showsBorder: Bool = true,
        cornerRadius: CGFloat? = nil,
        accessibilityLabel: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.aspect = aspect
        self.contentMode = contentMode
        self.showsBorder = showsBorder
        self.cornerRadiusOverride = cornerRadius
        self.accessibilityLabelText = accessibilityLabel
        self.content = content
    }

    public var body: some View {
        let tokens = theme.imageFrame
        let radius = cornerRadiusOverride ?? tokens.cornerRadius
        let shape = RoundedRectangle(cornerRadius: radius, style: .continuous)

        Group {
            if let ratio = aspect.ratio {
                // Fixed aspect slot from width; overlay fill/fit so media cannot
                // expand LazyVGrid / stack cells via intrinsic image size.
                Color.clear
                    .aspectRatio(ratio, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        mediaLayer(tokens: tokens)
                    }
                    .clipShape(shape)
            } else {
                mediaLayer(tokens: tokens)
                    .frame(maxWidth: .infinity, minHeight: tokens.minHeight)
                    .clipShape(shape)
            }
        }
        .overlay {
            if showsBorder {
                shape.strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
            }
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: accessibilityLabelText == nil ? .contain : .ignore)
        .accessibilityLabel(accessibilityLabelText ?? "Image")
        .accessibilityAddTraits(.isImage)
    }

    @ViewBuilder
    private func mediaLayer(tokens: any HIGImageFrameTokens) -> some View {
        Group {
            switch contentMode {
            case .fill:
                content()
                    .scaledToFill()
            case .fit:
                content()
                    .scaledToFit()
            @unknown default:
                content()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .clipped()
        .background(theme.colors.fillPrimary)
    }
}

extension HIGImageFrame where Content == HIGImageFramePlaceholderView {
    /// Creates an empty frame showing a themed placeholder icon.
    public init(
        aspect: HIGImageFrameAspect = .photo,
        showsBorder: Bool = true,
        cornerRadius: CGFloat? = nil,
        accessibilityLabel: String? = "Image placeholder"
    ) {
        self.init(
            aspect: aspect,
            contentMode: .fit,
            showsBorder: showsBorder,
            cornerRadius: cornerRadius,
            accessibilityLabel: accessibilityLabel,
            content: { HIGImageFramePlaceholderView() }
        )
    }
}

/// Default empty-state media for ``HIGImageFrame`` convenience initializers.
public struct HIGImageFramePlaceholderView: View {
    @Environment(\.higTheme) private var theme

    public init() {}

    public var body: some View {
        let tokens = theme.imageFrame
        ZStack {
            theme.colors.fillPrimary
            Image(systemName: "photo")
                .font(.system(size: tokens.placeholderIconPointSize, weight: .regular))
                .foregroundStyle(theme.colors.labelSecondary)
                .accessibilityHidden(true)
        }
    }
}

#if DEBUG
#Preview("HIGImageFrame") {
    struct HIGImageFramePreviewHostView: View {
        @Environment(\.higTheme) private var theme

        var body: some View {
            VStack(spacing: HIGSpacing.lg.rawValue) {
                HIGImageFrame(aspect: .widescreen, accessibilityLabel: "Gradient demo") {
                    LinearGradient(
                        colors: [theme.colors.accent, theme.colors.fillPrimary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }

                HIGImageFrame(aspect: .square)

                HIGImageFrame(aspect: .portrait, contentMode: .fill, accessibilityLabel: "Portrait media") {
                    LinearGradient(
                        colors: [theme.colors.accent, theme.colors.fillPrimary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
                .frame(maxWidth: 160)
            }
            .padding()
        }
    }

    return HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGImageFramePreviewHostView()
    }
}

#Preview("HIGImageFramePlaceholderView") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        HIGImageFramePlaceholderView()
            .frame(height: 120)
            .padding()
    }
}
#endif
