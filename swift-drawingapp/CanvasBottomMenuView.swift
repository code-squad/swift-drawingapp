//
//  CanvasBottomMenuView.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

struct CanvasBottomMenuView: View {
  var rectangleAction: (() -> Void)?
  var drawingAction: (() -> Void)?
  var isDrawing: Bool

  var body: some View {
    HStack(spacing: 12) {
      Button {
        rectangleAction?()
      } label: {
        Label("사각형", systemImage: "rectangle")
      }
      .buttonStyle(CanvasBottomMenuButtonStyle())

      Button {
        drawingAction?()
      } label: {
        Label("드로잉", systemImage: "pencil.and.outline")
          .if(isDrawing) { view in
            view.foregroundColor(.green)
          }
      }
      .buttonStyle(CanvasBottomMenuButtonStyle())
    }

  }
}

struct CanvasBottomMenuButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 17, weight: .semibold))
      .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
      .background(Color(UIColor.secondarySystemBackground))
      .cornerRadius(14)
  }
}

struct CanvasBottomMenuView_Previews: PreviewProvider {
  static var previews: some View {
    CanvasBottomMenuView(isDrawing: false)
  }
}
