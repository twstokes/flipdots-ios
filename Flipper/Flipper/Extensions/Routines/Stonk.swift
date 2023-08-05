//
//  PerfectPong.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/30/21.
//

import SwiftGFXWrapper

enum Stonk: Int {
    case doge
    case gme
    case amc
    
    var name: String {
        switch self {
        case .doge:
            return "$DOGE"
        case .gme:
            return "$GME"
        case .amc:
            return "$AMC"
        }
    }
    
    var price: Float {
        switch self {
        case .doge:
            return 0.054321
        case .amc:
            return 10.27
        case .gme:
            return 178.51
        }
    }
}

extension GFXMatrix {
    func stonk(_ stonk: Stonk) {
        let stonkName = stonk.name
        var lastPrice = stonk.price
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 5
        formatter.minimumFractionDigits = 5

        setFrameBlock { [unowned self] in
            fillScreen(0)
            setTextWrap(false)
            setFont(.PicopixelFont)
            setCursor(1, y: 5)
            self.print(stonkName)

            let price = lastPrice + Float.random(in: -0.00001...0.00001)
            
            // round to compare the numbers we're showing, not the true values (helps smooth changes out)
            if (price * 100000).rounded() >= (lastPrice * 100000).rounded() {
                drawArrow(.up)
            } else {
                drawArrow(.down)
            }

            setCursor(1, y: 12)
            let outputString = formatter.string(from: NSNumber(value: price))
            let substring = outputString?.prefix(7)
            let final = String(substring!)
            self.print(final)
            lastPrice = price
        }
        
        enum Arrow {
            case down, up
        }
        
        func drawArrow(_ arrow: Arrow) {
            drawLine(24, y0: 5, x1: 24, y1: 1, color: 1)
            
            switch arrow {
            case .down:
                drawLine(22, y0: 3, x1: 24, y1: 5, color: 1)
                drawLine(24, y0: 5, x1: 26, y1: 3, color: 1)
            case .up:
                drawLine(22, y0: 3, x1: 24, y1: 1, color: 1)
                drawLine(24, y0: 1, x1: 26, y1: 3, color: 1)
            }
        }
    }
}
