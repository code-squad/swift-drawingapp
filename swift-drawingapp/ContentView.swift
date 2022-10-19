//
//  ContentView.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    GeometryReader { geometryProxy in
      CanvasView(viewModel: CanvasViewModel(), size: geometryProxy.size)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
