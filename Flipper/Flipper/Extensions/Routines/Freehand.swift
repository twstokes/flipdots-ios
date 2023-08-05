//
//  PerfectPong.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/30/21.
//

import SwiftGFXWrapper

extension GFXMatrix {
    func freehand(isPreview: Bool) {
        // freehand mode isn't handled by the matrix itself
        guard isPreview else {
            setFrameBlock(nil)
            fillScreen(0)
            return
        }
        
        var pixelsDrawn = 0
        setFrameBlock { [unowned self] in
            drawPixel(
                Int.random(in: 0..<width()),
                y: Int.random(in: 0..<height()),
                color: 1
            )
            
            pixelsDrawn += 1
            
            if pixelsDrawn >= 128 {
                fillScreen(0)
                pixelsDrawn = 0
            }
        }
    }
}
