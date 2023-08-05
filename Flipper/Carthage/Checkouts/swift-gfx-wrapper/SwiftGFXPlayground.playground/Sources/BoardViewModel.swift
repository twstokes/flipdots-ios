import Foundation
import UIKit

import SwiftGFXWrapper

public struct BoardViewModel {
    public let matrix: GFXMatrix
    private let buffer: [Pixel]
    
    var rows: Int {
        matrix.height()
    }
    
    var cols: Int {
        matrix.width()
    }
    
    public init(rows: Int, cols: Int) {
        // a buffer to track our pixel state
        buffer = (0..<cols*rows).map { _ in Pixel() }
        
        // create a new matrix
        matrix = GFXMatrix(rows: rows, cols: cols)
        
        // set the function that's fired on every pixel draw
        matrix.setDrawCallback { [self] x, y, color in
           let dot = buffer[x + y * cols]
           
           // increase performance by doing minimal work
           if dot.color != color {
               dot.color = color
           }
        }
        
        // use a frame driver to handle the timing of each frame
        let driver = DisplayLinkDriver()
        // tell the driver what function to call on every frame step
        driver.setStepBlock(matrix.step)
        
        // start the driver
        driver.start()
    }
    
    func getPixelAt(row: Int, col: Int) -> Pixel? {
        let idx = row*matrix.width() + col
        
        guard buffer.indices.contains(idx) else {
            return nil
        }

        return buffer[idx]
    }
}
