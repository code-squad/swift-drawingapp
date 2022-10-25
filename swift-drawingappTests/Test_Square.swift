//
//  Test_Square.swift
//  swift-drawingappTests
//
//  Created by 김상진 on 2022/10/25.
//

import XCTest

class Test_Square: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func test_isContain_성공() {
        let points = [
            CGPoint(x: 8, y:798),
            CGPoint(x: 8, y:898),
            CGPoint(x: 108, y:898),
            CGPoint(x: 108, y:798),
            CGPoint(x: 8, y:798),
        ]
        let square = Square(points: points)
        
        let targetPoint = CGPoint(x: 100, y: 800)
        let isContain = square.isContain(point: targetPoint)
        XCTAssertEqual(isContain, true)
    }

    func test_isContain_실패() {
        let points = [
            CGPoint(x: 8, y:798),
            CGPoint(x: 8, y:898),
            CGPoint(x: 108, y:898),
            CGPoint(x: 108, y:798),
            CGPoint(x: 8, y:798),
        ]
        let square = Square(points: points)
        
        let targetPoint = CGPoint(x: 100, y: 700)
        let isContain = square.isContain(point: targetPoint)
        XCTAssertEqual(isContain, false)
    }
}
