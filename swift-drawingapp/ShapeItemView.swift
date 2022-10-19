//
//  ShapeItemView.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

struct ShapeItemView: View {
  var viewModel: ShapeItemViewModel

  var body: some View {
    AnyView(viewModel.item.view)
      .if(viewModel.isSelected) { view in
        view.border(Color(UIColor.systemRed), width: 5)
      }
      .offset(viewModel.offset)
      .onTapGesture {
        viewModel.didTap?()
      }
  }
}
