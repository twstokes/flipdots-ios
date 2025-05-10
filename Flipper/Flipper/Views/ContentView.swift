//
//  ContentView.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 11/14/20.
//

import SwiftUI

struct ContentView: View {
    @State var routine: GraphicsRoutine = .freehand

    // todo - maybe better as case iterable?
    let routines: [GraphicsRoutine] = [.freehand, .clock, .cube, .perfectPong, .textScroll, .gpt, .stonk(.doge), .flipFlop]
//    let routines: [GraphicsRoutine] = []

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                BoardView(routine: $routine)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(routines, id: \.self) { routine in
                            BoardPreviewView(routine: routine)
                                .onTapGesture { self.routine = routine }
                        }
                    }
                    .frame(maxHeight: 200)
                }
            }.padding()
        }
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
