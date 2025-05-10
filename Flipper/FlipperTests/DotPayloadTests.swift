//
//  DotPayloadTests.swift
//  FlipperTests
//
//  Created by Tanner W. Stokes on 3/29/21.
//

import XCTest

class DotPayloadTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDotPayload() throws {
        let colsPerPanel = 28
        let dotsPerCol = 7
        // asuming 28 columns, 7 dots per column
        let dots = (0 ..< colsPerPanel * dotsPerCol).map { _ in Dot() }
        // flip the top left
        dots[0].flipped = true
        // flip the bottom right
        dots[dotsPerCol * colsPerPanel - 1].flipped = true
        // flip the bottom left
        dots[colsPerPanel * (dotsPerCol - 1)].flipped = true

        let payload = dots.toPayload(panels: 1, colsPerPanel: colsPerPanel, dotsPerCol: dotsPerCol)
        // top and bottom dots flipped
        XCTAssertEqual(payload[0], 65)
        XCTAssertEqual(payload[colsPerPanel - 1], 64)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
