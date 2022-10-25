//
//  Color+Ext.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/25.
//

import Foundation
import UIKit

extension UIColor {
    static func getColor(colorAssets: ColorAssets) -> UIColor {
        switch colorAssets {
        case .systemBlue:
            return .systemBlue
        case .systemGreen:
            return .systemGreen
        case .systemBrown:
            return .systemBrown
        case .systemIndigo:
            return .systemIndigo
        case .systemPurple:
            return .systemPurple
        case .systemGray:
            return .systemGray
        }
    }
}
