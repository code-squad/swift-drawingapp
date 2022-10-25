//
//  File.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/25.
//

import Foundation

enum ColorAssets: CaseIterable {
    case systemBlue
    case systemGreen
    case systemBrown
    case systemIndigo
    case systemPurple
    case systemGray
    
    static func randomColor() -> Self {
        ColorAssets.allCases.filter { $0 != .systemGray }.randomElement() ?? .systemBlue
    }
}
