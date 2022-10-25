//
//  Test_ColorAssets.swift
//  swift-drawingappTests
//
//  Created by 김상진 on 2022/10/25.
//

import XCTest

class Test_ColorAssets: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func test_randomColor_실패() {
        let randomColor = ColorAssets.randomColor()
         
        XCTAssertEqual(randomColor == ColorAssets.systemGray, false)
    }

}
