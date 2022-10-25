//
//  Teat_DrawingStore.swift
//  swift-drawingappTests
//
//  Created by 김상진 on 2022/10/25.
//

import XCTest

class Teat_DrawingStore: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func test_findSquare_성공() throws {
        let drawingStore = DrawingStore()
        
        drawingStore.appendData(
            data: Square(points: [
                CGPoint(x: 8, y:798),
                CGPoint(x: 8, y:898),
                CGPoint(x: 108, y:898),
                CGPoint(x: 108, y:798),
                CGPoint(x: 8, y:798),
            ])
        )
        drawingStore.appendData(
            data: Square(points: [
                CGPoint(x: 308, y:874),
                CGPoint(x: 308, y:974),
                CGPoint(x: 408, y:974),
                CGPoint(x: 408, y:874),
                CGPoint(x: 308, y:874),
            ])
        )
        
        let targetPoint = CGPoint(x: 350, y: 900)
        let square = drawingStore.findSquare(point: targetPoint)
        
        XCTAssertEqual(square != nil, true)
    }
    
    func test_findSquare_실패() throws {
        let drawingStore = DrawingStore()
        
        drawingStore.appendData(
            data: Square(points: [
                CGPoint(x: 8, y:798),
                CGPoint(x: 8, y:898),
                CGPoint(x: 108, y:898),
                CGPoint(x: 108, y:798),
                CGPoint(x: 8, y:798),
            ])
        )
        drawingStore.appendData(
            data: Square(points: [
                CGPoint(x: 308, y:874),
                CGPoint(x: 308, y:974),
                CGPoint(x: 408, y:974),
                CGPoint(x: 408, y:874),
                CGPoint(x: 308, y:874),
            ])
        )
        
        let targetPoint = CGPoint(x: 300, y: 700)
        let square = drawingStore.findSquare(point: targetPoint)
        
        XCTAssertEqual(square != nil, false)
    }
}
