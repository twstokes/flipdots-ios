//
//  PerfectPong.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/30/21.
//

import SwiftGFXWrapper

extension GFXMatrix {
    func clock() {
        setFrameBlock { [unowned self] in
            fillScreen(0)
            setTextWrap(false)
            setFont(.TomThumbFont)
//            showTime()
            spellTime()
        }
        
        func showTime() {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            setCursor(1, y: 10)
            self.print(formatter.string(from: Date()))
        }
        
        func spellTime() {
            let cal = Calendar.current
            let components = cal.dateComponents([.hour, .minute], from: Date())

            let formatter = NumberFormatter()
            formatter.numberStyle = .spellOut
            
            guard let hourComponent = components.hour, let minuteComponent = components.minute else {
                return
            }

            let hour = NSNumber(value: hourComponent)
            let minute = NSNumber(value: minuteComponent)

            setCursor(1, y: 7)
            self.print(formatter.string(from: hour))
            
            setCursor(1, y: 13)
            self.print(formatter.string(from: minute))
        }
    }
}
