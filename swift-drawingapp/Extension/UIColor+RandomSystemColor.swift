//
//  UIColor+RandomSystemColor.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import UIKit

extension UIColor {

    static let systemColorsWithoutRed: [UIColor] = [.systemGray, .systemMint, .systemCyan, .systemBlue, .systemPink, .systemTeal, .systemBrown, .systemIndigo, .systemOrange, .systemGreen, .systemYellow]

    static var randomColor: UIColor {
        return UIColor.systemColorsWithoutRed.randomElement() ?? .systemGray5
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
      let rect = CGRect(origin: .zero, size: size)
      UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
      color.setFill()
      UIRectFill(rect)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

      guard let cgImage = image?.cgImage else { return nil }
      self.init(cgImage: cgImage)
    }
  }
