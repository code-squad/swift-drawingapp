//
//  CanvasViewRepresentable.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/11/02.
//

import Foundation
import Combine

protocol CanvasViewRepresentable: AnyObject {
    
    var shapes: any Publisher<[(UUID, ShapeViewRepresentable)], Never> { get }
    var transformShape: (UUID, ShapeViewRepresentable) -> ShapeViewRepresentable { get }
    /// 뷰에 맞도록 좌표계를 컨버팅하는 데에 쓴다
    func setSizeOfView(_ size: CGSize)
}

extension CanvasViewRepresentable {
    var transformShape: (UUID, ShapeViewRepresentable) -> ShapeViewRepresentable {
        { $1 }
    }
}
