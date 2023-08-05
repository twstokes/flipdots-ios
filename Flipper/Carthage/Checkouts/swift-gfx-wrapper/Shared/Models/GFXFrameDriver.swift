import Foundation

/// Handles driving each frame computed for a `GFXMatrix`.
public protocol GFXFrameDriver {
    /// Block that's fired with each frame step.
    func setStepBlock(_ block: (() -> Void)?)
    /// Frame rate to fire blocks.
    func setFrameRate(fps: Int)
    /// Start the driver.
    func start()
    /// Stop the driver.
    func stop()
    /// Pause the driver.
    func pause()
    /// Resume the driver.
    func resume()
}
