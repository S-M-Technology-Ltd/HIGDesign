import HIGPlatform
import HIGThemesContract
import HIGTokensComponent
import HIGTokensRaw
import SwiftUI

#if !os(watchOS)
import AVKit
#endif

/// A themed video surface for admin media, training, and product demos.
///
/// On platforms with AVKit, wraps SwiftUI ``VideoPlayer``. On watchOS, shows a
/// themed placeholder (playback is owned by the host). Chrome resolves from
/// ``HIGTheme/videoPlayer``.
public struct HIGVideoPlayer: View {
    private let url: URL?
    private let title: String?
    private let caption: String?

    @Environment(\.higTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

#if !os(watchOS)
    @State private var player: AVPlayer?
#endif

    /// Creates a video player.
    /// - Parameters:
    ///   - url: Optional media URL; when `nil`, a placeholder is shown.
    ///   - title: Optional heading above the player.
    ///   - caption: Optional supporting text below the title.
    public init(
        url: URL? = nil,
        title: String? = nil,
        caption: String? = nil
    ) {
        self.url = url
        self.title = title
        self.caption = caption
    }

    public var body: some View {
        let tokens = theme.videoPlayer
        let capabilities = HIGPlatformCapabilities.current
        let minHeight = max(tokens.minHeight, capabilities.minimumTouchTarget * 3)
        let shape = RoundedRectangle(cornerRadius: tokens.cornerRadius, style: .continuous)

        VStack(alignment: .leading, spacing: tokens.stackSpacing) {
            if title != nil || caption != nil {
                VStack(alignment: .leading, spacing: theme.spacing.compactItem) {
                    if let title {
                        Text(title)
                            .font(tokens.titleFont)
                            .foregroundStyle(theme.colors.labelPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityAddTraits(.isHeader)
                    }
                    if let caption {
                        Text(caption)
                            .font(tokens.captionFont)
                            .foregroundStyle(theme.colors.labelSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }

            mediaSurface(tokens: tokens, minHeight: minHeight, shape: shape)
        }
        .opacity(isEnabled ? theme.opacity.full : theme.opacity.disabled)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabelText)
#if !os(watchOS)
        .onAppear { configurePlayer() }
        .onChange(of: url) { _, _ in configurePlayer() }
        .onDisappear {
            player?.pause()
            player = nil
        }
#endif
    }

    @ViewBuilder
    private func mediaSurface(
        tokens: any HIGVideoPlayerTokens,
        minHeight: CGFloat,
        shape: RoundedRectangle
    ) -> some View {
#if os(watchOS)
        placeholder(tokens: tokens, minHeight: minHeight, shape: shape)
#else
        Group {
            if let player {
                VideoPlayer(player: player)
                    .frame(maxWidth: .infinity, minHeight: minHeight)
                    .clipShape(shape)
                    .overlay {
                        shape.strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
                    }
                    .disabled(!isEnabled)
            } else {
                placeholder(tokens: tokens, minHeight: minHeight, shape: shape)
            }
        }
#endif
    }

    private func placeholder(
        tokens: any HIGVideoPlayerTokens,
        minHeight: CGFloat,
        shape: RoundedRectangle
    ) -> some View {
        ZStack {
            theme.colors.fillPrimary
            VStack(spacing: tokens.stackSpacing) {
                Image(systemName: "play.rectangle.fill")
                    .font(.system(size: tokens.placeholderIconPointSize, weight: .regular))
                    .foregroundStyle(theme.colors.labelSecondary)
                    .accessibilityHidden(true)
                Text(url == nil ? "No video" : "Loading video")
                    .font(tokens.captionFont)
                    .foregroundStyle(theme.colors.labelSecondary)
            }
            .padding(tokens.contentPadding)
        }
        .frame(maxWidth: .infinity, minHeight: minHeight)
        .clipShape(shape)
        .overlay {
            shape.strokeBorder(theme.colors.separator, lineWidth: tokens.borderWidth)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(url == nil ? "Video placeholder" : "Loading video")
    }

    private var accessibilityLabelText: String {
        if let title {
            "Video player, \(title)"
        } else {
            "Video player"
        }
    }

#if !os(watchOS)
    private func configurePlayer() {
        player?.pause()
        guard let url else {
            player = nil
            return
        }
        player = AVPlayer(url: url)
    }
#endif
}

#if DEBUG
#Preview("HIGVideoPlayer") {
    HIGThemeableView(theme: HIGComponentPreviewTheme()) {
        VStack(spacing: HIGSpacing.lg.rawValue) {
            HIGVideoPlayer(
                title: "Product walkthrough",
                caption: "Placeholder when no URL is provided."
            )
        }
        .padding()
    }
}
#endif
