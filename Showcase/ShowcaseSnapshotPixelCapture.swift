import HIGDesign
import HIGPlatform
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

@MainActor
public enum ShowcaseSnapshotPixelCapture {
    public static func renderPNG(
        component: ShowcaseComponent?,
        catalogSnapshot: Bool = false,
        themeChoice: ShowcaseThemeChoice,
        colorScheme: ColorScheme,
        platform: ShowcaseSnapshotPlatform?,
        canvasSize: CGSize,
        deviceBackground: ShowcaseSnapshotDeviceBackground? = nil
    ) -> Data? {
        let idiom = platform?.userInterfaceIdiom

        return HIGSnapshotPlatformOverride.using(idiom) {
            let content = pixelMatchView(
                component: component,
                catalogSnapshot: catalogSnapshot,
                themeChoice: themeChoice,
                colorScheme: colorScheme,
                platform: platform,
                canvasSize: canvasSize
            )

            let contentPNG: Data?
            #if os(macOS)
            let windowTitle = component?.title ?? "HIGDesign"
            contentPNG = renderPNGOnMac(
                from: content,
                size: canvasSize,
                colorScheme: colorScheme,
                capturesWindowChrome: platform == .macos && deviceBackground != nil,
                windowTitle: windowTitle
            )
            #elseif os(iOS)
            contentPNG = renderPNGOnIOS(from: content, size: canvasSize, colorScheme: colorScheme)
            #else
            contentPNG = nil
            #endif

            guard let contentPNG else { return nil }

            if let deviceBackground, platform != nil {
                return ShowcaseSnapshotDeviceCompositor.composite(
                    contentPNG: contentPNG,
                    deviceBackground: deviceBackground
                )
            }

            return contentPNG
        }
    }

    @ViewBuilder
    private static func pixelMatchView(
        component: ShowcaseComponent?,
        catalogSnapshot: Bool,
        themeChoice: ShowcaseThemeChoice,
        colorScheme: ColorScheme,
        platform: ShowcaseSnapshotPlatform?,
        canvasSize: CGSize
    ) -> some View {
        let theme = themeChoice.makeTheme()
        let isMacDeviceFrame = platform == .macos

        HIGThemeableView(theme: theme) {
            Group {
                if catalogSnapshot {
                    catalogSnapshotView(
                        themeChoice: themeChoice,
                        colorScheme: colorScheme,
                        platform: platform
                    )
                } else if let platform, let component {
                    platformMatchedCatalogDetail(
                        component: component,
                        platform: platform,
                        themeChoice: themeChoice,
                        colorScheme: colorScheme
                    )
                } else if let component {
                    ShowcaseSnapshotView(component: component, platform: nil)
                }
            }
            .preferredColorScheme(colorScheme)
            .background(isMacDeviceFrame ? .clear : theme.colors.backgroundPrimary)
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
        .background(isMacDeviceFrame ? .clear : theme.colors.backgroundPrimary)
    }

    @ViewBuilder
    private static func catalogSnapshotView(
        themeChoice: ShowcaseThemeChoice,
        colorScheme: ColorScheme,
        platform: ShowcaseSnapshotPlatform?
    ) -> some View {
        let catalog = ShowcaseSnapshotCatalogCaptureView(
            themeChoice: themeChoice,
            colorScheme: colorScheme
        )

        if let platform {
            switch platform {
            case .macos, .visionos:
                catalog
            default:
                catalog
                    .applySnapshotLayoutTraits(for: platform)
            }
        } else {
            catalog
        }
    }

    @ViewBuilder
    private static func platformMatchedCatalogDetail(
        component: ShowcaseComponent,
        platform: ShowcaseSnapshotPlatform,
        themeChoice: ShowcaseThemeChoice,
        colorScheme: ColorScheme
    ) -> some View {
        let detail = ShowcaseSnapshotCatalogDetailView(
            component: component,
            iconSettings: .constant(ShowcaseIconSettings())
        )

        switch platform {
        case .macos:
            ShowcaseSnapshotPlatformCaptureView(
                component: component,
                themeChoice: themeChoice,
                colorScheme: colorScheme
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 100)
            .padding(.bottom, 230)
            .padding(.leading, 280)
            .padding(.trailing, 280)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .visionos:
            NavigationSplitView {
                Color.clear
                    .frame(width: 0, height: 0)
                    .navigationSplitViewColumnWidth(0)
            } detail: {
                detail
            }
        default:
            NavigationStack {
                detail
            }
            .applySnapshotLayoutTraits(for: platform)
        }
    }

    #if os(macOS)
    private static func renderPNGOnMac<Content: View>(
        from content: Content,
        size: CGSize,
        colorScheme: ColorScheme,
        capturesWindowChrome: Bool,
        windowTitle: String = "HIGDesign"
    ) -> Data? {
        let appearance = NSAppearance(named: colorScheme == .dark ? .darkAqua : .aqua)
        let hostingView = NSHostingView(rootView: content)
        hostingView.frame = CGRect(origin: .zero, size: size)
        hostingView.appearance = appearance
        hostingView.wantsLayer = true

        if capturesWindowChrome {
            hostingView.layer?.backgroundColor = NSColor.clear.cgColor
        } else {
            hostingView.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        }

        let window = NSWindow(
            contentRect: CGRect(origin: .zero, size: size),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.appearance = appearance
        window.contentView = hostingView
        window.hasShadow = false
        window.isOpaque = !capturesWindowChrome
        window.backgroundColor = capturesWindowChrome ? .clear : .windowBackgroundColor

        return captureOffScreen(window: window, hostingView: hostingView)
    }

    private static func captureOffScreen(window: NSWindow, hostingView: NSView) -> Data? {
        window.setFrameOrigin(NSPoint(x: -20_000, y: -20_000))
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        NSApp.activate(ignoringOtherApps: true)
        window.displayIfNeeded()
        hostingView.layoutSubtreeIfNeeded()
        drainMainRunLoop()

        let scale: CGFloat = 2
        let captureView = hostingView
        let captureBounds = hostingView.bounds

        captureView.wantsLayer = true
        captureView.layer?.contentsScale = scale

        let pixelWidth = Int(captureBounds.width * scale)
        let pixelHeight = Int(captureBounds.height * scale)
        guard pixelWidth > 0, pixelHeight > 0,
              let rep = NSBitmapImageRep(
                bitmapDataPlanes: nil,
                pixelsWide: pixelWidth,
                pixelsHigh: pixelHeight,
                bitsPerSample: 8,
                samplesPerPixel: 4,
                hasAlpha: true,
                isPlanar: false,
                colorSpaceName: .deviceRGB,
                bytesPerRow: 0,
                bitsPerPixel: 0
              ) else {
            return nil
        }

        rep.size = captureBounds.size
        captureView.cacheDisplay(in: captureBounds, to: rep)
        return rep.representation(using: .png, properties: [:])
    }
    #endif

    #if os(iOS)
    private static func renderPNGOnIOS<Content: View>(
        from content: Content,
        size: CGSize,
        colorScheme: ColorScheme
    ) -> Data? {
        let hostingController = UIHostingController(rootView: content)
        hostingController.overrideUserInterfaceStyle = colorScheme == .dark ? .dark : .light
        hostingController.view.frame = CGRect(origin: .zero, size: size)
        hostingController.view.bounds = CGRect(origin: .zero, size: size)
        hostingController.view.backgroundColor = .systemBackground

        let window = UIWindow(frame: CGRect(origin: .zero, size: size))
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first {
            window.windowScene = windowScene
        }
        window.rootViewController = hostingController
        window.isHidden = false
        window.makeKeyAndVisible()
        window.layoutIfNeeded()
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()
        drainIOSMainRunLoop()

        let format = UIGraphicsImageRendererFormat()
        format.scale = 2
        format.opaque = false
        let image = UIGraphicsImageRenderer(size: size, format: format).image { _ in
            hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
        }
        window.isHidden = true
        return image.pngData()
    }

    private static func drainIOSMainRunLoop() {
        let deadline = Date().addingTimeInterval(0.5)
        while Date() < deadline {
            RunLoop.current.run(mode: .default, before: Date().addingTimeInterval(0.01))
        }
    }
    #endif

    private static func drainMainRunLoop() {
        #if os(macOS)
        let deadline = Date().addingTimeInterval(1.0)
        while Date() < deadline {
            RunLoop.current.run(mode: .default, before: Date().addingTimeInterval(0.01))
        }
        #endif
    }
}

private extension View {
    @ViewBuilder
    func applySnapshotLayoutTraits(for platform: ShowcaseSnapshotPlatform) -> some View {
        switch platform {
        case .ios, .watchos:
            self
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .regular)
        case .ipados:
            self
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .regular)
        default:
            self
        }
    }
}

private extension ShowcaseSnapshotPlatform {
    var userInterfaceIdiom: HIGUserInterfaceIdiom {
        switch self {
        case .ios: .phone
        case .ipados: .pad
        case .macos: .mac
        case .tvos: .tv
        case .watchos: .watch
        case .visionos: .vision
        }
    }
}