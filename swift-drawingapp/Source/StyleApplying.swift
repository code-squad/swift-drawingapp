//
//  StyleApplying.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

protocol StyleApplying: AnyObject {
    var color: Color? { get set }
    var lineColor: Color? { get set }
}
