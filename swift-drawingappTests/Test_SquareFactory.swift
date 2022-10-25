//
//  Test_SquareFactory.swift
//  swift-drawingappTests
//
//  Created by 김상진 on 2022/10/25.
//

import XCTest

class Test_SquareFactory: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func test_getRange_성공() throws {
        let squareMaker = SquareFactory()
        
        let rect = CGRect(x: 0, y: 0, width: 300, height: 500)
        let range = squareMaker.possibleStartingPointRange(rect: rect)
        XCTAssertEqual(range.rangeX, 0..<200)
        XCTAssertEqual(range.rangeY, 0..<400)
    }

    func test_getRandomStartingPoint_범위_안에_존재() {
        let squareMaker = SquareFactory()
        
        let range = squareMaker.randomStartingPoint(rangeX: 0..<200, rangeY: 0..<300)
        XCTAssertTrue(range.x < 200)
        XCTAssertTrue(range.y < 300)
    }
    
    func test_getRect_범위_안에_존재() {
        let squareMaker = SquareFactory()
        
        let rect = CGRect(x: 0, y: 0, width: 300, height: 500)
        let square = squareMaker.getRect(rect: rect)
        XCTAssertTrue(square.origin.x < 200)
        XCTAssertTrue(square.origin.y < 400)
        XCTAssertTrue(square.size.width == 100)
        XCTAssertTrue(square.size.height == 100)
    }

}
