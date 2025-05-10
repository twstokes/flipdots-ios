import SwiftUI

import SwiftGFXWrapper

struct BoardView: View {
    @StateObject var vm = BoardViewModel(rows: 14, cols: 28)
    private let pixelType: PixelType = .circle

    enum PixelType {
        case square
        case circle
    }

    var body: some View {
        Canvas { context, size in
            let rectSize = size.width / CGFloat(vm.cols)
            for row in 0 ..< vm.rows {
                for col in 0 ..< vm.cols {
                    let pixel = vm.getPixelAt(row: row, col: col)
                    let rect = createRect(x: CGFloat(col), y: CGFloat(row), size: rectSize, padding: 0.1)

                    let shape: Path
                    switch pixelType {
                    case .square:
                        shape = Path(rect)
                    case .circle:
                        shape = Path(ellipseIn: rect)
                    }
                    context.fill(shape, with: .color(pixel))
                }
            }
        }
        .background(Color.gray.opacity(0.2))
        .aspectRatio(.init(width: vm.cols, height: vm.rows), contentMode: .fit)
    }

    private func createRect(x: CGFloat, y: CGFloat, size: CGFloat, padding: CGFloat) -> CGRect {
        let paddingOffset = (padding * size)
        return CGRect(
            x: (x * size) + (paddingOffset / 2),
            y: (y * size) + (paddingOffset / 2),
            width: size - paddingOffset,
            height: size - paddingOffset
        )
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
