//
//  BoardView.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 11/14/20.
//

import SwiftUI

import SwiftGFXWrapper

struct BoardView: View {
    @State var fps: Float = 5.0
    @State private var textInput: String = "text scroller"
    @State private var selectedItem = 0
    @State private var dragLocation: CGPoint = .zero

    @Binding var routine: GraphicsRoutine

    @ObservedObject private var vm: BoardViewModel

    init(routine: Binding<GraphicsRoutine>, isPreview: Bool = false) {
        vm = BoardViewModel(rows: 14, cols: 28, isPreview: isPreview)
        _routine = routine
    }

    private var dragGesture: some Gesture {
        return DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { dragGesture in
                // don't do any work in the preview boards
                guard !vm.isPreview else {
                    return
                }

                dragLocation = dragGesture.location
            }
            .onEnded { dragGesture in
                // don't do any work in the preview boards
                guard !vm.isPreview else {
                    return
                }

                dragLocation = dragGesture.location
            }
    }

    private var dragMask: GestureMask {
        guard !vm.isPreview, routine.capabilities.contains(.touchInput) else {
            return .subviews
        }
        return .all
    }

    // TODO: - hone in on the dot pitch by looking at the real board
    var body: some View {
        GeometryReader { _ in
            VStack {
                // use a spacer to center the content
                // because geometry reader fills the entire space
                Spacer()
                // no spacing so we get full hit region
                VStack(spacing: 0) {
                    ForEach(0 ..< vm.rows) { row in
                        // no spacing so we get full hit region
                        HStack(spacing: 0) {
                            ForEach(0 ..< vm.cols) { col in
                                if let dot = vm.getPixelAt(row: row, col: col) {
                                    DotView(
                                        dot: dot,
                                        readOnly: vm.isPreview || !routine.capabilities.contains(.touchInput),
                                        dragLocation: vm.isPreview ? .constant(.zero) : $dragLocation
                                    )
                                    .contentShape(Rectangle())
                                }
                            }
                        }
                    }
                }
                .gesture(dragGesture, including: dragMask)
                .dropDestination(for: Data.self) { items, location in
                    guard let item = items.first else { return false }
                    guard let uiImage = UIImage(data: item) else { return false }
                    routine = .gptImage(uiImage)
                    return true
                }

                if !vm.isPreview {
                    TweakBarView(vm: vm, capabilities: routine.capabilities, fps: $fps, textInput: $textInput, selectedItem: $selectedItem)
                        .animation(.linear, value: 0.1)
                }

                Spacer()
            }.onAppear {
                vm.start(routine: routine)
            }.onChange(of: routine) { [routine] newState in
                // hack - because freehand doesn't go through the matrix buffer,
                // we need to clear at the dot buffer level when moving away from it
                if routine == .freehand {
                    vm.clear()
                }

                // TODO: - improve this
                switch newState {
                case .textScroll:
                    vm.setInputString(textInput)
                case .gpt:
                    textInput = ""
                    vm.setInputString("")
                default:
                    vm.start(routine: newState)
                }
            }.onChange(of: selectedItem) { _ in
                vm.setSelectedItem(selectedItem)
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(routine: .constant(.bouncyDot), isPreview: false)
    }
}
