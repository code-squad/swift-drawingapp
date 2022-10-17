//
//  swift_drawingappTests.swift
//  swift-drawingappTests
//
//  Created by JK on 2022/07/04.
//

import XCTest
import Combine
@testable import swift_drawingapp

class swift_drawingappTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func test_RectangleInfo_select() throws {
        let rectangle = RectangleInfo(color: .brown, area: .init(origin: .init(x: 0, y: 0), size: .init(width: 100, height: 100)))
        var isSelected: Bool = false
        rectangle.isSelectedPublisher
            .sink { isSelected = $0 }
            .store(in: &cancellables)
        XCTAssertFalse(isSelected)
        rectangle.select()
        XCTAssertTrue(isSelected)
    }

    func test_DrawingInfo_resize() throws {
        let drawing = DrawingInfo(color: .brown, lineWidth: 4, area: .init(origin: .init(x: 0, y: 0), size: .init(width: 100, height: 100)))
        var area: Area = .init(origin: .init(x: 0, y: 0), size: .init(width: 100, height: 100))
        var points: [Point] = []

        drawing.areaPublisher
            .sink { area = $0 }
            .store(in: &cancellables)

        drawing.pointsPublisher
            .sink { points = $0 }
            .store(in: &cancellables)

        XCTAssertEqual(area.origin.x, 0)
        XCTAssertEqual(area.origin.y, 0)
        XCTAssertEqual(area.size.width, 100)
        XCTAssertEqual(area.size.height, 100)
        XCTAssertEqual(points, [])

        drawing.resizeToDrawnArea(with: [.init(x: 20, y: 20), .init(x: 40, y: 40)])
        XCTAssertEqual(area.origin.x, 16)
        XCTAssertEqual(area.origin.y, 16)
        XCTAssertEqual(area.size.width, 28)
        XCTAssertEqual(area.size.height, 28)
        XCTAssertEqual(points, [.init(x: 4, y: 4), .init(x: 24, y: 24)])
    }
}
