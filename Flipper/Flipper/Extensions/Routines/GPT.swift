//
//  GPT.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/20/23.
//

import SwiftGFXWrapper
import SwiftOpenAI

extension GFXMatrix {
    func gpt(preview: Bool, query: String = "", buffer _: [Dot]? = nil) {
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

        let service = OpenAIServiceFactory.service(apiKey: openAIToken, configuration: configuration)
        let parameters = ChatCompletionParameters(
            messages: [
                .init(role: .user, content: .text(query)),
                .init(role: .system, content: .text(
                    "You are a machine that only outputs a 28 columns x 14 rows array of ones and zeros in JSON format. Your job is to draw low resolution (28x14) monochrome images. The data structure you return is always an array of 14 subarrays containing 28 integers. Each integer is either 0 or 1. The only key in the JSON object is 'image'."
                )),
            ],
            model: .custom("gpt-4.1"), responseFormat: .type("json_object")
        )
        Task {
            do {
                let chatCompletionObject = try await service.startChat(parameters: parameters)
                guard let content = chatCompletionObject.choices.first?.message.content else {
                    Swift.print("No content message found.")
                    return
                }

                let parsedMessage = try GPTMessageParser(content: content, cols: width(), rows: height()).parseMessageString()

                await MainActor.run {
                    setFrameBlock(nil)
                    fillScreen(0)

                    for (ridx, row) in parsedMessage.enumerated() {
                        for (cidx, col) in row.enumerated() {
                            drawPixel(cidx, y: ridx, color: col == 0 ? 0 : 1)
                        }
                    }
                }
            } catch {
                Swift.print(error.localizedDescription)
            }
        }
    }

    enum GPTResponseError: Error {
        case noResponseText
    }
}
