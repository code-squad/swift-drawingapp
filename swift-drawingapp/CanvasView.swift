//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

struct CanvasView: View {
  @StateObject var viewModel: CanvasViewModel
  let size: CGSize

  // TODO
  @StateObject private var liveDrawing = CanvasLiveDrawing()

  var body: some View {
    ZStack {
      Color(uiColor: .white)
        .ignoresSafeArea()

      ForEach(viewModel.itemViewModels, id: \.item.id) { itemViewModel in
        ShapeItemView(viewModel: itemViewModel)
      }

      ShapeItemView(viewModel: .init(item: liveDrawing.path, isSelected: false))

      VStack {
        Spacer()

        CanvasBottomMenuView(
          rectangleAction: {
            addRectangle()
          },
          drawingAction: {
            addDrawingPath()
          },
          isDrawing: liveDrawing.isDrawing)
        .padding()
      }
    }
    .gesture(liveDrawing.dragGesture)
  }

  private func addRectangle() {
    viewModel.addItem(
      ShapeRectangle(
        color: UIColor.systemColors.randomElement()!,
        size: .init(width: 100, height: 100),
        offset: CGSize(width: CGFloat.random(in: (-size.width/2...size.width/2)),
                       height: CGFloat.random(in: (-size.height/2...size.height/2)))))
  }

  private func addDrawingPath() {
    liveDrawing.start(
      didFinish: { path in
        viewModel.addItem(
          ShapeDrawingPath(
            color: UIColor.systemColors.randomElement()!,
            points: path.points))
      }
    )
  }
}

struct CanvasView_Previews: PreviewProvider {
  static var previews: some View {
    CanvasView(viewModel: CanvasViewModel(), size: CGSize(width: 400, height: 800))
  }
}
