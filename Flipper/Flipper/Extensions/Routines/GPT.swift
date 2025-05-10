//
//  GPT.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/20/23.
//

import SwiftGFXWrapper

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

        let customSession = URLSession(configuration: configuration)
    }

    enum GPTResponseError: Error {
        case noResponseText
    }
}
