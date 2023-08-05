//
//  GPT.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/20/23.
//

import SwiftGFXWrapper

extension GFXMatrix {
    /// Attempts to center text horizontally and vertically within the view. Does not work well for all fonts.
    func centerText(text: String, size: Int = 1, font: Font? = nil) {
        setFrameBlock(nil)
        fillScreen(0)
        setTextWrap(false)
        setTextSize(size)

        if let font {
            setFont(font)
        }

        let x = width()
        var x1 = Int16(0), y1 = Int16(0), w = UInt16(0), h = UInt16(0)

        getTextBoundsPtr(text, x: x, y: self.getCursorY(), x1: &x1, y1: &y1, width: &w, height: &h)

        /*
            compute the vertical middle taking into account that custom fonts use
            a different baseline than the default font

            Adafruit docs:
            For example, whereas the cursor position when printing with the classic font identified the top-left corner of
            the character cell, with new fonts the cursor position indicates the baseline — the bottom-most row — of
            subsequent text.
        */
        let verticalMiddle = getCursorY() - Int(y1) + (height() / 2) - (Int(h) / 2)
        let textWidth = Int(w)
        let horizontalMiddle = self.width() / 2
        let horizontalStart = horizontalMiddle - (textWidth / 2)

        setCursor(horizontalStart, y: verticalMiddle)
        self.print(text)
    }
}
