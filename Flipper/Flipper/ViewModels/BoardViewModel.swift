import Foundation
import UIKit

import SwiftGFXWrapper

class BoardViewModel: ObservableObject {
    private let matrix: GFXMatrix
    private let buffer: [Dot]
    private let driver = DisplayLinkDriver()

    @Published private(set) var inverted = false
    @Published var state: BoardState

    private var networkEnabled: Bool {
        return UserDefaults.standard.bool(forKey: "networkEnabled")
    }

    private var client: UDPClient?

    let isPreview: Bool

    var rows: Int {
        matrix.height()
    }

    var cols: Int {
        matrix.width()
    }

    init(rows: Int, cols: Int, isPreview: Bool) {
        buffer = (0 ..< cols * rows).map { _ in Dot() }
        matrix = GFXMatrix(rows: rows, cols: cols)
        state = .stopped
        self.isPreview = isPreview

        matrix.setDrawCallback { [self] x, y, color in
            var flipped = color != 0
            flipped = self.inverted ? !flipped : flipped
            self.buffer[x + y * cols].flipped = flipped
        }

        initializeClient()

        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged), name: Notification.Name(Notifications.networkChanged), object: nil)

        driver.setStepBlock {
            self.matrix.step()

            if self.networkEnabled {
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    guard let self = self else { return }
                    // TODO: - some sort of debouncing? Is that necessary?
                    self.client?.send(self.buffer) { error in
                        if let error = error {
                            print(error)
                        }
                    }
                }
            }
        }

        driver.setFrameRate(fps: 5)
        driver.start()
    }

    func initializeClient() {
        // never let previews run the board
        guard !isPreview else {
            return
        }

        client = UDPClient(host: "YOUR IP HERE", port: "4210")
        client?.start()
    }

    @objc func networkChanged() {
        // TODO: This gets called a bunch of times from the notification center,
        // when we really just need one message
        if networkEnabled && client == nil {
            initializeClient()
            return
        }

        if !networkEnabled {
            client = nil
            return
        }
    }

    func start(routine: GraphicsRoutine) {
        state = .running
        driver.resume()

        if isPreview {
            setFrameRate(fps: 1)
        }

        switch routine {
        case .freehand:
            if !isPreview {
                setFrameRate(fps: 20)
            }

            matrix.freehand(isPreview: isPreview)
        case .bouncyDot:
            matrix.bouncyDot()
        case .textScroll:
            matrix.scrollText(text: "text scroller", font: .DefaultFont)
        case .cube:
            matrix.cube()
        case .flipFlop:
            setFrameRate(fps: 2)
            matrix.flipFlop()
        case let .stonk(stonk):
            setFrameRate(fps: 1)
            matrix.stonk(stonk)
        case .clock:
            setFrameRate(fps: 1)
            matrix.clock()
        case .perfectPong:
            matrix.perfectPong()
        case .gpt:
            matrix.gpt(preview: isPreview)
        }

        matrix.step()
    }

    func pause() {
        driver.pause()
        state = .paused
    }

    func resume() {
        driver.resume()
        state = .running
    }

    func stop() {
        matrix.setFrameBlock(nil)
        // note - this will respect inverted mode
        matrix.fillScreen(0)
        matrix.step()
        state = .stopped
    }

    func clear() {
        // note: this line is only needed for routines that skip the
        // matrix buffer, e.g. freehand
        // it would probably be better for freehand to still go through the matrix
        // buffer to simplify things and open the door for future operations like saving
        buffer.forEach { $0.flipped = inverted || false }

        matrix.fillScreen(0)
    }

    func invert() {
        // toggle the state for each dot in the buffer directly so
        // we don't have to worry about if the driver is paused
        buffer.forEach { $0.flipped = !$0.flipped }
        inverted.toggle()
    }

    func gptSubmit(_ text: String) {
        print("Submitting \(text) to ChatGPT")
        matrix.gpt(preview: false, query: text)
    }

    func setFrameRate(fps: Float) {
        driver.setFrameRate(fps: Int(fps))
    }

    // todo - something cleaner than this
    func setInputString(_ text: String) {
        matrix.scrollText(text: text, font: .DefaultFont)
    }

    func setSelectedItem(_ tag: Int) {
        let stonk = Stonk(rawValue: tag)!
        // hack to that we don't have to wait for the next frame
        // better responsiveness
        setFrameRate(fps: 20)
        start(routine: .stonk(stonk))
    }

    func getPixelAt(row: Int, col: Int) -> Dot? {
        let idx = row * matrix.width() + col

        guard buffer.indices.contains(idx) else {
            return nil
        }

        return buffer[idx]
    }
}
