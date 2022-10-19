//
//  View+Extensions.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import SwiftUI

extension View {
  @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }
}
