import UIKit

/// Single source of truth for player orientation behaviour.
///
/// To change how the player handles orientation, edit **only this file**.
/// Everything in `PlayerViewController` and `HomeView` that touches
/// orientation delegates here.
enum PlayerOrientation {

    // ── What the player prefers when it first appears ──────────────────────
    /// The orientation the player requests on appearance (and on foreground resume).
    static var preferredOnEntry: UIInterfaceOrientationMask {
        isLandscapeLocked ? .landscape : []   // [] = don't force, follow device
    }

    /// The single orientation used for `preferredInterfaceOrientationForPresentation`.
    static var preferredPresentation: UIInterfaceOrientation {
        isLandscapeLocked ? .landscapeRight : .unknown
    }

    // ── What orientations the player supports while it's on screen ──────────
    static var supported: UIInterfaceOrientationMask {
        isLandscapeLocked ? .landscape : .all
    }

    // ── Convenience: push geometry update on the given scene ───────────────
    /// Call this whenever you want to (re-)apply the player's preferred orientation.
    /// Does nothing when landscape is not locked so the device is free to rotate.
    static func applyToScene(_ scene: UIWindowScene?) {
        guard let scene, !preferredOnEntry.isEmpty else { return }
        scene.requestGeometryUpdate(.iOS(interfaceOrientations: preferredOnEntry)) { _ in }
    }

    // ── Private ────────────────────────────────────────────────────────────
    private static var isLandscapeLocked: Bool {
        (UserDefaults.standard.object(forKey: "lockLandscape") as? Bool) ?? true
    }
}
