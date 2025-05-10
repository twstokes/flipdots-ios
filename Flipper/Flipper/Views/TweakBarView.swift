//
//  TweakBarView.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 9/11/21.
//

import SwiftUI

// Displays options based on capabilities
struct TweakBarView: View {
    let vm: BoardViewModel
    let capabilities: [RoutineCapability]
    @Binding var fps: Float
    @Binding var textInput: String
    @Binding var selectedItem: Int

    @State private var showingSettings = false

    var body: some View {
        HStack {
            Button(action: {
                // TODO: - handle inversion in freehand drag
                vm.invert()
            }) {
                Image(systemName: vm.inverted ? "t.circle.fill" : "t.circle")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 25, height: 25)
            }

            if capabilities.contains(.gptSubmit) {
                Button(action: {
                    if !textInput.isEmpty {
                        vm.gptSubmit(textInput)
                    }
                }) {
                    Image("chatgpt")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)
                }
            }

//                        if routine.capabilities.contains(.stop) {
//                            Button(action: {
//                                vm.stop()
//                            }) {
//                                Image(systemName: "xmark.circle")
//                                    .resizable()
//                                    .foregroundColor(.gray)
//                                    .frame(width: 25, height: 25)
//                            }
//                        }

            if vm.state != .stopped {
                if capabilities.contains(.playPause) {
                    Button(action: {
                        if vm.state == .running {
                            vm.pause()
                        } else if vm.state == .paused {
                            vm.resume()
                        }
                    }) {
                        Image(systemName: vm.state == .running ? "pause.circle" : "play.circle")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 25, height: 25)
                    }
                }

                if capabilities.contains(.speed) {
                    Slider(
                        value: $fps,
                        in: 1 ... 30,
                        onEditingChanged: { _ in
                            vm.setFrameRate(fps: fps)
                        }
                    ).accentColor(Colors.orange)
                }
            }

            if capabilities.contains(.stringInput) {
                TextField("", text: $textInput)
                    { _ in } onCommit: {
                        vm.setInputString(textInput)
                    }
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    .foregroundColor(Colors.orange)
                    .font(.system(size: 25, design: .monospaced))
            }

            if capabilities.contains(.clear) {
                Button(action: {
                    textInput = ""
                    vm.clear()
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 25, height: 25)
                }
            }

            if capabilities.contains(.picker) {
                HStack {
                    Picker("Testing", selection: $selectedItem) {
                        Text("$DOGE").tag(0)
                        Text("$GME").tag(1)
                        Text("$AMC").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color(UIColor.systemBackground))
                }
            }

            Spacer()

            Button(action: {
                showingSettings.toggle()
            }) {
                Image(systemName: "gear")
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 25, height: 25)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct TweakBarView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
