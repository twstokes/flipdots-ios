//
//  PerfectPong.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/30/21.
//

import SwiftGFXWrapper

extension GFXMatrix {
    func bouncyDot(size: Int = 1) {
        var x = size - 1
        var y = size - 1
        var addingX = true
        var addingY = true
        
        setFrameBlock { [unowned self] in
            fillScreen(0)
            fillRect(x, y: y, width: size, height: size, color: 1)
            
            if x >= width() - size || x <= 0 {
                addingX.toggle()
            }
            
            if y >= height() - size || y <= 0 {
                addingY.toggle()
            }
            
            x = addingX ? x-1 : x+1
            y = addingY ? y-1 : y+1
        }
    }
}
