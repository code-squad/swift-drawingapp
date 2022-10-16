//
//  CanvasTests.swift
//  swift-drawingappTests
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import XCTest
@testable import swift_drawingapp

final class CanvasTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testAddShape() {
        let canvas = Canvas(size: .init(width: 100, height: 100))
        XCTAssert(canvas.addShape(Rectangle(origin: .init(x: 0, y: 0), size: .init(width: 30, height: 30))))
        XCTAssertFalse(canvas.addShape(Rectangle(origin: .init(x: 80, y: 80), size: .init(width: 100, height: 100))))
    }

}
