import SwiftUI

import SwiftGFXWrapper

struct BoardView: View {
    static private let rows = 16, cols = 32
    static private let spacing = 0.002
    private let vm = BoardViewModel(rows: rows, cols: cols)

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: geo.size.width * BoardView.spacing) {
                ForEach((0..<vm.rows)) { row in
                    HStack(spacing: geo.size.width * BoardView.spacing) {
                        ForEach((0..<vm.cols)) { col in
                            if let pixel = vm.getPixelAt(row: row, col: col) {
                                PixelView(pixel: pixel)
                            }
                        }
                    }
                }
            }.background(Color.gray.opacity(0.3))
        }.aspectRatio(
            .init(width: BoardView.cols, height: BoardView.rows),
            contentMode: .fit
        )
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}

