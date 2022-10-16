//
//  ShapeTests.swift
//  swift-drawingappTests
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import XCTest
@testable import swift_drawingapp

final class ShapeTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testRectanglePointsCreation() {
        let rect1 = Rectangle(origin: .init(x: 0, y: 0), size: .init(width: 100, height: 100))
        XCTAssertEqual(
            rect1.points,
            [
                .init(x: 0, y: 0),
                .init(x: 100, y: 0),
                .init(x: 100, y: 100),
                .init(x: 0, y: 100),
                .init(x: 0, y: 0),
            ]
        )
        
        let rect2 = Rectangle(origin: .init(x: 25, y: 40), size: .init(width: 100, height: 80))
        XCTAssertEqual(
            rect2.points,
            [
                .init(x: 25, y: 40),
                .init(x: 25+100.0, y: 40),
                .init(x: 25+100.0, y: 40+80.0),
                .init(x: 25, y: 40+80.0),
                .init(x: 25, y: 40),
            ]
        )
    }
    
    func testRectanglePointSelection() {
        let rect = Rectangle(origin: .init(x: 25, y: 40), size: .init(width: 100, height: 80))
        XCTAssertFalse(rect.contains(.init(x: 0, y: 0)))
        XCTAssert(rect.contains(.init(x: 26, y: 119)))
    }
}
