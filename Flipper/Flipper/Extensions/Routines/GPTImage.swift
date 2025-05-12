//
//  GPTImage.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/10/25.
//

import SwiftGFXWrapper
import SwiftOpenAI
import UIKit

extension GFXMatrix {
    func gptImage(image: UIImage? = nil) {
        setFrameBlock(nil)
        fillScreen(0)

        let imageToProcess = image ?? UIImage(named: "mountain")

        guard let imageToProcess else {
            Swift.print("Failed to load image")
            return
        }

        guard let converted = monochromeBooleanCanvas(from: imageToProcess) else {
            Swift.print("Failed to convert to boolean canvas")
            return
        }

        guard converted.count == height() else {
            Swift.print("Height data incorrect")
            return
        }

        for col in converted {
            guard col.count == width() else {
                Swift.print("Width data incorrect")
                return
            }
        }

//        MainActor.run {
        setFrameBlock(nil)
        fillScreen(0)

        for (ridx, row) in converted.enumerated() {
            for (cidx, col) in row.enumerated() {
                drawPixel(cidx, y: ridx, color: col == true ? 1 : 0)
            }
        }
//        }
    }
}
