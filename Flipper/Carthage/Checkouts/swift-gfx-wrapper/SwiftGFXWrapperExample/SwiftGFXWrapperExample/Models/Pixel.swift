import Foundation
import SwiftUI

/// Observable pixel drawn by a GFXMatrix.
class Pixel: ObservableObject, Identifiable {   
    @Published var color = Color.black
}
