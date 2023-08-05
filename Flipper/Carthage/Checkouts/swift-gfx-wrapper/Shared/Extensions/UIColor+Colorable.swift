#if os(iOS) || os(watchOS)
import Foundation
import UIKit

extension UIColor: Colorable {
    // the GFX library uses 565 16-bit colors
    public func to565() -> Int {
        var r = CGFloat(0), g = CGFloat(0), b = CGFloat(0)
        self.getRed(&r, green: &g, blue: &b, alpha: nil)
        
        let red = Int(r * 31) << 11
        let green = Int(g * 63) << 5
        let blue = Int(b * 31)
        
        return red | green | blue
    }
    
    public convenience init(_ int565: Int) {
        let r = (int565 & 0xF800) >> 11
        let g = (int565 & 0x7E0) >> 5
        let b = (int565 & 0x1F)
        
        self.init(red: CGFloat(r) / 31, green: CGFloat(g) / 63, blue: CGFloat(b) / 31, alpha: 1)
    }
}
#endif
