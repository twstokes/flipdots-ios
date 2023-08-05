import Foundation

/// Observable pixel drawn by a GFXMatrix.
public class Pixel: ObservableObject, Identifiable {
    @Published public var color: Int = 0
}
