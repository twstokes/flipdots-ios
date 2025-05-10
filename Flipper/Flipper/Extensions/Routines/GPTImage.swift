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
    func gptImage() {
        setFrameBlock(nil)
        fillScreen(0)

        guard let mountain = UIImage(named: "mountain") else {
            Swift.print("Failed to load mountain image")
            return
        }
        guard let converted = monochromeBooleanCanvas(from: mountain) else {
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
