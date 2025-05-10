import Foundation
import SwiftUI
import UIKit

import SwiftGFXWrapper

class BoardViewModel: ObservableObject {
    @Published var boardBuffer: [Color]

    // Public to make Playground access convenient
    let matrix: GFXMatrix
    private var pixels: [Color]

    var rows: Int {
        matrix.height()
    }

    var cols: Int {
        matrix.width()
    }

    init(rows: Int, cols: Int) {
        // a buffer to track our pixel state
        pixels = (0 ..< cols * rows).map { _ in .black }
        boardBuffer = pixels

        // create a new matrix
        matrix = GFXMatrix(rows: rows, cols: cols)

        // set the function that's fired on every pixel draw
        matrix.setDrawCallback { [self] x, y, color in
            pixels[x + y * cols] = Color(color)
        }

        // use a frame driver to handle the timing of each frame
        let driver = DisplayLinkDriver()
        // tell the driver what function to call on every frame step
        driver.setStepBlock {
            self.matrix.step()
            self.boardBuffer = self.pixels
        }

        // example of an included graphics routine to scroll text
        matrix.scrollText(text: "Hello!", color: UIColor.orange)

        // example of a local graphics routine to manipulate the matrix
        // bouncyBox()

        // start the driver
        driver.start()
    }

    func getPixelAt(row: Int, col: Int) -> Color {
        let idx = row * matrix.width() + col
        return boardBuffer[idx]
    }

    private func bouncyBox() {
        var x = Int.random(in: 0 ..< matrix.width())
        var y = Int.random(in: 0 ..< matrix.height())
        var addingX = false
        var addingY = false

        matrix.setFrameBlock {
            self.matrix.fillScreen(0)
            self.matrix.drawPixel(x, y: y, color: UIColor.green.to565())

            if x >= self.matrix.width() - 1 || x <= 0 {
                addingX.toggle()
            }

            if y >= self.matrix.height() - 1 || y <= 0 {
                addingY.toggle()
            }

            x = addingX ? x + 1 : x - 1
            y = addingY ? y + 1 : y - 1
        }
    }
}
