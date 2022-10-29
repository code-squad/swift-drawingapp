//
//  Test_ConvertToShape.swift
//  swift-drawingappTests
//
//  Created by 김상진 on 2022/10/29.
//

import XCTest

class Test_ConvertToShape: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func test_convertToShape_성공() throws {
        let converter = ChatCommandConverter()
        
        let inputSquare = Square(points: [
            CGPoint(x: 8, y:798),
            CGPoint(x: 8, y:898),
            CGPoint(x: 108, y:898),
            CGPoint(x: 108, y:798),
            CGPoint(x: 8, y:798),
        ])
        let command = Command(header: "0x20", id: "ray", length: inputSquare.toJsonData()?.count, data: inputSquare.toJsonData(), shapeType: "square")
        
        guard let shape = try? converter.convertToShape(command: command) else {
            XCTFail()
            return
        }
        
        if let outputSquare = shape as? Square {
            XCTAssertEqual(inputSquare, outputSquare)
        } else {
            XCTFail()
        }
    }

}
