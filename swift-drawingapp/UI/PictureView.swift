//
//  PictureView.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import UIKit

protocol PictureView where Self: UIView {
    init(frame: CGRect, color: UIColor, lineWidth: CGFloat, port: DrawUIInPort)
    func selected(at point: Point?)
}
