//
//  swift_drawingappTests.swift
//  swift-drawingappTests
//
//  Created by JK on 2022/07/04.
//

import XCTest
@testable import swift_drawingapp
import Combine

final class swift_drawingappTests: XCTestCase {

    var subscription = Set<AnyCancellable>()

    override func tearDownWithError() throws {

        subscription.removeAll()
    }

    func test_AddRectangle() {
        let viewModel = ViewModel()

        let expectation = self.expectation(description: "test_AddRectangle")

        viewModel.state.canvasRect.send(.init(origin: .zero, size: .init(width: 1000, height: 1000)))
        viewModel.action.addRectangle.send(())

        viewModel.state.drawingObjects
            .filter { !$0.isEmpty }
            .sink { objects in
                defer { expectation.fulfill() }
                guard let rect = objects.first else {
                    XCTFail("Not added")
                    return
                }
                XCTAssert(rect is Rectangle)
            }.store(in: &subscription)


        waitForExpectations(timeout: 2, handler: nil)

    }

    func test_AddPathShape() {
        let viewModel = ViewModel()

        let expectation = self.expectation(description: "test_AddPathShape")

        viewModel.state.canvasRect.send(.init(origin: .zero, size: .init(width: 1000, height: 1000)))
        viewModel.action.addObject.send(PathShape(isSelected: false, origin: .zero, size: .zero, color: .randomColor, paths: []))

        viewModel.state.drawingObjects
            .filter { !$0.isEmpty }
            .sink { objects in
                defer { expectation.fulfill() }
                guard let object = objects.first else {
                    XCTFail("Not added")
                    return
                }
                XCTAssert(object is PathShape)
            }.store(in: &subscription)


        waitForExpectations(timeout: 2, handler: nil)

    }

    func test_AddSelectObject() {
        let viewModel = ViewModel()

        let expectation = self.expectation(description: "test_AddPathShape")

        viewModel.state.canvasRect.send(.init(origin: .zero, size: .init(width: 1000, height: 1000)))
        let object = PathShape(isSelected: false, origin: .zero, size: .zero, color: .randomColor, paths: [])
        viewModel.state.drawingObjects
            .filter { !$0.isEmpty }
            .prefix(1)
            .sink { objects in
                guard let object = objects.first else {
                    XCTFail("Not added")
                    return
                }
                viewModel.action.selectObject.send(object)
            }.store(in: &subscription)

        viewModel.state.drawingObjects
            .filter { !$0.isEmpty }
            .dropFirst()
            .sink { objects in
                defer { expectation.fulfill() }
                guard let object = objects.first else {
                    XCTFail("Not added")
                    return
                }
                XCTAssert(object.isSelected)
            }.store(in: &subscription)

        viewModel.action.addObject.send(object)


        waitForExpectations(timeout: 3, handler: nil)

    }
}
