//
//  Settings.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/28/21.
//

import Foundation

class BoardSettings: ObservableObject {
    @Published var routine: GraphicsRoutine = .bouncyDot
    
//    // temporary
//    init() {
//        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
//            self.routine = .textScroll
//        }
//    }
}
