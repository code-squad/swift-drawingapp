//
//  CanvasViewModelTests.swift
//  CanvasViewModelTests
//
//  Created by Haeseok Lee on 2022/07/04.
//

import XCTest
@testable import swift_drawingapp

class CanvasViewModelTests: XCTestCase {

    
    var sut: CanvasViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CanvasViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = CanvasViewModel()
    }

    func test_draw_rectangle() {
        // given
        let tool = PolygonTool()
        let layoutInfo = LayoutInfo(size: .init(width: 100, height: 100), center: .init(x: 300, y: 400))
        
        // when
        sut.draw(tool: tool, layoutInfo: layoutInfo, uiInfo: nil)
        
        // then
        XCTAssertEqual(1, sut.drawing.items.count)
        XCTAssertTrue(type(of: sut.drawing.items.first!) is RectangleView.Type)
    }
    
    func test_draw_stroke() {
        // given
        let tool = InkTool(ink: .init(lineWidth: 3, lineColor: .systemRed))
        
        // when
        sut.draw(tool: tool, beganAt: Point(x: 100, y: 100))
        
        sut.draw(tool: tool, valueChangedAt: Point(x: 100, y: 101))
        sut.draw(tool: tool, valueChangedAt: Point(x: 100, y: 102))
        sut.draw(tool: tool, valueChangedAt: Point(x: 100, y: 103))
        sut.draw(tool: tool, valueChangedAt: Point(x: 100, y: 104))
        
        sut.draw(tool: tool, endedAt: Point(x: 100, y: 105))
        
        // then
        XCTAssertEqual(1, sut.drawing.items.count)
        XCTAssertTrue(type(of: sut.drawing.items.first!) is Stroke.Type)
    }
    
    func test_select_rectangle() {
        // given
        let itemID = UUID()
        let item = RectangleView(id: itemID, layoutInfo: .init(), uiInfo: .init())
        
        // when
        sut.select(item: item)
        
        // then
        XCTAssertEqual(1, sut.drawing.selectedItems.count)
        XCTAssertTrue(type(of: sut.drawing.selectedItems.first!) is RectangleView.Type)
        XCTAssertEqual(sut.drawing.selectedItems.first!.id, itemID)
    }
    
    func test_select_when_double_tapped_rectangle() {
        // given
        let itemID = UUID()
        let item = RectangleView(id: itemID, layoutInfo: .init(), uiInfo: .init())
        
        // when
        sut.select(item: item)
        sut.select(item: item) // double tap
        
        // then
        XCTAssertTrue(sut.drawing.selectedItems.isEmpty)
    }
}
