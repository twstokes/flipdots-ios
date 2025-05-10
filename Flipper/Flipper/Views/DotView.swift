//
//  DotView.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 11/14/20.
//

import SwiftUI

import SwiftGFXWrapper

struct DotView: View {
    @ObservedObject var dot: Dot
    var readOnly = false

    @Binding var dragLocation: CGPoint

//    @State private var location: CGRect = .zero

    var body: some View {
        GeometryReader { geo in
            Circle()
                .foregroundColor(dot.flipped ? Colors.orange : Colors.darkDray)
                .background(Color.black)
                //            .rotation3DEffect(
                //                dot.flipped ? .degrees(180) : .degrees(0),
                //                axis: (x: 0.2, y: -0.5, z: 0.0)
                //            )
                //            .animation(.linear(duration: 0.15))
                //            .animation(.linear(duration: 0.01))
                .gesture(tapGesture, including: tapMask)
                .scaledToFit()
//                .contentShape(Rectangle())
                .padding(geo.size.width * 0.05)
                .onChange(of: dragLocation) { dragLocation in
                    // we don't care about already flipped dots
                    guard !dot.flipped else {
                        return
                    }

                    if geo.frame(in: .global).contains(dragLocation) {
//                        print("Drag location: \(dragLocation)")
//                        print("My location: \(location)")
                        dot.flipped = true
                    }
                }
//                .onAppear {
//                    location = geo.frame(in: .global)
//                }
        }
    }

    private var tapGesture: some Gesture {
        return TapGesture()
            .onEnded { dot.flipped.toggle() }
    }

    private var tapMask: GestureMask {
        return readOnly ? .subviews : .all
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        DotView(dot: Dot(), readOnly: false, dragLocation: .constant(.zero))
    }
}
