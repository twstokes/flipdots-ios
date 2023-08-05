//
//  GPT.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/20/23.
//

import SwiftGFXWrapper
import OpenAISwift

extension GFXMatrix {
    func gpt(preview: Bool, query: String = "", buffer: [Dot]? = nil) {
        if preview {
            centerText(text: "GPT", size: 2, font: .PicopixelFont)
            return
        }

        guard !query.isEmpty else {
            return
        }

        /// routine to show while we're waiting on a query
        bouncyDot()

        guard let openAIToken = Bundle.main.infoDictionary?["OPENAI_TOKEN"] as? String else {
            fatalError("The token required for the OpenAI API was not available!")
        }

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120

        let customSession = URLSession(configuration: configuration)
        let sessionConfig = OpenAISwift.Config(session: customSession)
        let openAI = OpenAISwift(authToken: openAIToken, config: sessionConfig)

        Task {
            do {
                Swift.print("Sending chat now.")

                /// 5-20-23 - This times out most of the time and has yet to work. Possibly with GPT-4 things will be better.
                let result = try await openAI.sendCompletion(with: "Draw a \(query) as a 1-bit display with 14 rows and 28 columns. Your response will be the compressed pixel buffer.", model: .gpt3(.davinci), maxTokens: 2000, temperature: 0)

/*
                /// Chat API
                let messages: [ChatMessage] = [
                    ChatMessage(role: .system, content: "You only reply with a JSON array of ones and zeroes. You are a 1-bit display with 14 rows and 28 columns."),
                    ChatMessage(role: .user, content: "Draw \(query)")
                ]
                let result = try await openAI.sendChat(with: messages, model: .chat(.chatgpt), temperature: 0)

                guard let responseText = result.choices?.first?.message.content else {
                    throw GPTResponseError.noResponseText
                }
*/
                Swift.print(result)
                guard let responseText = result.choices?.first?.text else {
                    throw GPTResponseError.noResponseText
                }

                let parser = GPTResponseParser(response: responseText, matrixPixelTotal: 14*28)
                let pixels = try parser.parseResponseString()
                Swift.print(pixels)

                await MainActor.run {
                    setFrameBlock(nil)
                    fillScreen(0)

                    for row in 0..<14 {
                        for col in 0..<28 {
                            drawPixel(col, y: row, color: pixels[col + (row * 28)])
                        }
                    }

                }


            } catch {
                Swift.print(error)
                await MainActor.run {
                    centerText(text: "error", font: .TomThumbFont)
                }
            }
        }
    }

    enum GPTResponseError: Error {
        case noResponseText
    }
}
