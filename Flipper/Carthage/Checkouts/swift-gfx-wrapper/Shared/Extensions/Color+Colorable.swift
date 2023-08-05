#if os(iOS) || os(watchOS)
import Foundation
import SwiftUI

extension Color: Colorable {
    public func to565() -> Int {
        return UIColor(self).to565()
    }
    
    public init(_ int565: Int) {
        self.init(UIColor(int565))
    }
}
#endif
