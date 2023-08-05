//
//  GPTResponseParser.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 5/20/23.
//

import Foundation

/// A type to handle parsing the expected responses from OpenAI
struct GPTResponseParser {
    let response: String
    let matrixPixelTotal: Int

    func parseResponseString() throws -> [Int] {
        /// Note: The decoder accounts for whitespace and newlines, so no need to trim them
        let decoder = JSONDecoder()
        guard let data = response.data(using: .utf8) else {
            throw GPTResponseParserError.pixelTotalMismatch
        }
        return try decoder.decode([Int].self, from: data)
    }
}

enum GPTResponseParserError: Error {
    /// we expected to parse width x height pixels exactly, but didn't
    case pixelTotalMismatch
}
