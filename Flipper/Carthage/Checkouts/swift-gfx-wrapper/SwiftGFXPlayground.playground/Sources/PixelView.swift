import SwiftUI

public struct PixelView: View {
    @ObservedObject public var pixel: Pixel

    public var body: some View {
        Rectangle()
            .fill(Color(pixel.color))
            .border(Color.gray.opacity(0.3))
            .scaledToFit()
    }
}
