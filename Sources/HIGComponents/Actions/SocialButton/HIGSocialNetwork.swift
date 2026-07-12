/// Supported social / account networks for ``HIGSocialButton``.
///
/// Icons use SF Symbols. Visual chrome stays on HIG semantic colors rather than
/// third-party brand palettes.
public enum HIGSocialNetwork: String, Sendable, CaseIterable, Equatable {
    case apple
    case google
    case facebook
    case x
    case linkedIn
    case gitHub
    case email
    case website

    /// Default button title for this network.
    public var defaultTitle: String {
        switch self {
        case .apple:
            "Continue with Apple"
        case .google:
            "Continue with Google"
        case .facebook:
            "Continue with Facebook"
        case .x:
            "Continue with X"
        case .linkedIn:
            "Continue with LinkedIn"
        case .gitHub:
            "Continue with GitHub"
        case .email:
            "Continue with Email"
        case .website:
            "Open website"
        }
    }

    /// Short label for icon-only accessibility.
    public var accessibilityName: String {
        switch self {
        case .apple: "Apple"
        case .google: "Google"
        case .facebook: "Facebook"
        case .x: "X"
        case .linkedIn: "LinkedIn"
        case .gitHub: "GitHub"
        case .email: "Email"
        case .website: "Website"
        }
    }

    /// SF Symbol name for the network.
    public var systemImage: String {
        switch self {
        case .apple:
            "apple.logo"
        case .google:
            "g.circle.fill"
        case .facebook:
            "f.circle.fill"
        case .x:
            "x.circle.fill"
        case .linkedIn:
            "l.circle.fill"
        case .gitHub:
            "chevron.left.forwardslash.chevron.right"
        case .email:
            "envelope.fill"
        case .website:
            "globe"
        }
    }
}
