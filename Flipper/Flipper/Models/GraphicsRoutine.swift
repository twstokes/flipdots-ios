//
//  GraphicsRoutine.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/28/21.
//

import Foundation

enum GraphicsRoutine: Hashable {
    case freehand
    case textScroll
    case bouncyDot
    case cube
    case flipFlop
    case stonk(Stonk)
    case clock
    case perfectPong
    case gpt

    var capabilities: [RoutineCapability] {
        switch self {
        case .freehand:
            return [.clear]
        case .textScroll:
            return [.stringInput, .playPause, .speed]
        case .bouncyDot, .cube, .flipFlop:
            return [.playPause, .stop, .speed]
        case .stonk:
            return [.picker]
        case .clock:
            return []
        case .perfectPong:
            return [.speed, .playPause]
        case .gpt:
            return [.stringInput, .gptSubmit, .clear]
        }
    }
}

enum RoutineCapability {
    case stringInput
    case playPause
    case stop
    case speed
    case picker
    case clear
    case gptSubmit
}
