extension GFXMatrix {
    // MARK: Graphics routines
    
    /// Flip back and forth all pixels between off and full brightness.
    open func flipFlop() {
        var flipped = false
        
        setFrameBlock { [unowned self] in
            fillScreen(flipped ? Int32.max : 0)
            flipped.toggle()
        }
    }

    /// Scrolls text in the middle of the matrix infinitely.
    ///
    /// - Parameters:
    ///   - text: String to output.
    ///   - font: Font to use.
    ///   - size: Font size.
    ///   - color: Color to use.
    ///   - verticalOffset: Vertical offset from middle.
    open func scrollText(
        text: String,
        font: Font? = nil,
        size: Int = 1,
        color: Colorable? = nil,
        verticalOffset: Int = 0
    ) {
        setTextWrap(false)
        setTextSize(size)
        
        if let font = font {
            setFont(font)
        }
        
        if let color = color {
            setTextColor(color.to565())
        }

        var x = width()
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
        let width = Int(w)
        
        setFrameBlock { [unowned self] in
            fillScreen(0)
            setCursor(x, y: verticalMiddle + verticalOffset)
            self.print(text)

            x = x - 1
            
            if (x < -width) {
                x = self.width()
            }
        }
    }
}
