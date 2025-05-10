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


        let prompt = "Draw a circle in the center of the canvas."
        let parameters = ChatCompletionParameters(
            messages: [
                .init(role: .user, content: .text(prompt)),
                .init(role: .system, content: .text("You are a machine that only outputs a 28x14 array of ones and zeros in JSON format. Your job is to draw low resolution (28x14) monochrome images."))],
            model: .custom("gpt-4.1-mini"), responseFormat: .type("json_object"))

        Task {
            let chatCompletionObject = try await service.startChat(parameters: parameters)
            self.print(chatCompletionObject.choices.first?.message.content ?? "No message")
        }

        // example response
        /*
         message =     {
             annotations =         (
             );
             content = "{\n  \"image\": [\n    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0],\n    [0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0],\n    [0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0],\n    [0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0],\n    [0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0],\n    [0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],\n    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]\n  ]\n}";
             refusal = "<null>";
             role = assistant;
         };
     }
         */
    }

    enum GPTResponseError: Error {
        case noResponseText
    }
}
