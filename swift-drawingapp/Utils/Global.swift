//
//  Global.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/19.
//

import Foundation

var systemColorNames: [String] {
    [
        "systemRed",
        "systemBlue",
        "systemCyan",
        "systemMint",
        "systemGray",
        "systemTeal",
        "systemBrown",
        "systemOrange",
        "systemPink",
        "systemYellow",
        "systemGreen"
    ]
}

var randomSystemColorName: String {
    systemColorNames[Int.random(in: 0..<systemColorNames.count)]
}
