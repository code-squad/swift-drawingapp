//
//  ShapeItem+ViewProviding.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

protocol ShapeItemViewProviding {
  associatedtype ContentView: View
  var view: ContentView { get }
}
