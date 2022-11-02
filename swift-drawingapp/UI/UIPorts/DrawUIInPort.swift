//
//  DrawUIInPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol DrawUIInPort: AnyObject {
    func touch(on pictureView: PictureView, at location: CGPoint?)
}
