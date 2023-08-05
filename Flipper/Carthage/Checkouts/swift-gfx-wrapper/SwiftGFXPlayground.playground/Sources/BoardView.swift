import SwiftUI

import SwiftGFXWrapper

public struct BoardView: View {
    public let vm: BoardViewModel
    
    public init(vm: BoardViewModel) {
        self.vm = vm
    }

    public var body: some View {
        GeometryReader { geo in
            VStack(spacing: geo.size.width * 0.005) {
                Spacer()
                ForEach((0..<vm.rows)) { row in
                    HStack(spacing: geo.size.width * 0.005) {
                        ForEach((0..<vm.cols)) { col in
                            if let pixel = vm.getPixelAt(row: row, col: col) {
                                PixelView(pixel: pixel)
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
