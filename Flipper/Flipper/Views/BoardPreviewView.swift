//
//  BoardPreviewView.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 11/14/20.
//

import SwiftUI

struct BoardPreviewView: View {
    let routine: GraphicsRoutine

    var body: some View {
        BoardView(routine: .constant(routine), isPreview: true)
            .contentShape(Rectangle())
            .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fit)
    }
}

struct BoardPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BoardPreviewView(routine: .bouncyDot)
    }
}
