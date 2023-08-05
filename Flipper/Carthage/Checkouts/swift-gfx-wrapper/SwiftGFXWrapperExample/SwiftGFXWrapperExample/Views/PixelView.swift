import SwiftUI

struct PixelView: View {
    @ObservedObject var pixel: Pixel

    var body: some View {
        Rectangle()
            .fill(pixel.color)
    }
}

struct PixelView_Previews: PreviewProvider {
    static let pixel: Pixel = {
        let p = Pixel()
        p.color = Color.red
        return p
    }()
    
    static var previews: some View {
        PixelView(pixel: pixel)
    }
}
