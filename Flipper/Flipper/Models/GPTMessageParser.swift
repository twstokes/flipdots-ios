//
//  GPTResponseParser.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/20/23.
//

import Foundation

/// A type to handle parsing the expected responses from OpenAI
struct GPTMessageParser {
    let content: String
    let cols: Int
    let rows: Int

    struct ResponseMessage: Decodable {
        let image: [[Int]]
    }

    func parseMessageString() throws -> [[Int]] {
        /// Note: The decoder accounts for whitespace and newlines, so no need to trim them
        let decoder = JSONDecoder()
        guard let data = content.data(using: .utf8) else {
            throw GPTResponseParserError.dataConversionFailed
        }
        let decoded = try decoder.decode(ResponseMessage.self, from: data)
        guard decoded.image.count == rows else {
            throw GPTResponseParserError.pixelTotalMismatch
        }
        for row in decoded.image {
            guard row.count == cols else {
                throw GPTResponseParserError.pixelTotalMismatch
            }
        }

        return decoded.image
    }
}

enum GPTResponseParserError: Error {
    case dataConversionFailed
    /// we expected to parse width x height pixels exactly, but didn't
    case pixelTotalMismatch
}
