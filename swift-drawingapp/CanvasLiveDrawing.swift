//
//  CanvasLiveDrawing.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

class CanvasLiveDrawing: ObservableObject {
  @Published private(set) var path = ShapeDrawingPath(color: .gray)
  @Published private(set) var dragGesture: AnyGesture<DragGesture.Value>?

  var isDrawing: Bool {
    return dragGesture != nil
  }

  func start(didFinish: ((ShapeDrawingPath) -> Void)?) {
    dragGesture = AnyGesture(
      DragGesture(minimumDistance: 0)
        .onChanged { [weak self] stroke in
          self?.path.addLine(to: stroke.location)
        }
        .onEnded { [weak self] _ in
          guard let path = self?.path else { return }
          didFinish?(path)
          self?.path = ShapeDrawingPath(color: .gray)
          self?.dragGesture = nil
        })
  }
}
