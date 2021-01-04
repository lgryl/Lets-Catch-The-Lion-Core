// Created 02/01/2021

import XCTest
@testable import LetsCatchTheLionCore

extension XCTestCase {
    internal func assertBoard(_ board: Board,
                              hasWidth expectedWidth: Int,
                              andHeight expectedHeight: Int,
                              _ message: @autoclosure () -> String = "",
                              file: StaticString = #filePath,
                              line: UInt = #line) {
        XCTAssertEqual(expectedWidth,
                       board.width,
                       message(),
                       file: file,
                       line: line)
        XCTAssertEqual(expectedHeight,
                       board.height,
                       message(),
                       file: file,
                       line: line)
    }
}
