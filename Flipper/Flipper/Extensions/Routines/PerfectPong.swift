//
//  PerfectPong.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/30/21.
//

import SwiftGFXWrapper

extension GFXMatrix {
    func perfectPong() {
        let midY = height() / 2
        
        var x = width() / 2
        var y = midY
        
        var lineLeftPos = midY
        var lineRightPos = midY
        
        var addingX = false
        var addingY = false
        
        let paddleLength = 3
        
        setFrameBlock { [unowned self] in
            fillScreen(0)
            
            drawLine(0, y0: lineLeftPos - paddleLength / 2, x1: 0, y1: lineLeftPos + paddleLength / 2, color: 1)
            drawLine(width() - 1, y0: lineRightPos - paddleLength / 2, x1: width() - 1, y1: lineRightPos + paddleLength / 2, color: 1)
            drawPixel(x, y: y, color: 1)
            
            if x >= width() - 2 || x <= 1 {
                addingX.toggle()
            }
            
            if y >= height() - 1 || y <= 0 {
                addingY.toggle()
            }
            
            x = addingX ? x+1 : x-1
            y = addingY ? y+1 : y-1

            if addingX {
                moveToTarget(item: &lineLeftPos, target: midY)
                moveToTarget(item: &lineRightPos, target: y)
            } else {
                moveToTarget(item: &lineLeftPos, target: y)
                moveToTarget(item: &lineRightPos, target: midY)
            }
        }
        
        func moveToTarget(item: inout Int, target: Int) {
            if item != target {
                item = item > target ? item - 1 : item + 1
            }
        }
    }
}
