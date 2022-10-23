//
//  CGSize+Extensions.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import UIKit

extension CGSize {
    
    var toSize: Size { .init(width: width, height: height) }
}
