//
//  CanvasViewModel.swift
//  swift-drawingapp
//
//  Created by Freddy on 2022/10/19.
//

import Foundation

class CanvasViewModel: ObservableObject {
  @Published private(set) var selectedItem: (any ShapeItem & ShapeItemSelectable)? = nil
  @Published private(set) var items: [any ShapeItem] = []

  func addItem(_ item: any ShapeItem) {
    items.append(item)
  }
}

extension CanvasViewModel {
  var itemViewModels: [ShapeItemViewModel] {
    items
      .compactMap { $0 as? any ShapeItem & ShapeItemViewProviding }
      .map { item in
        return .init(item: item, isSelected: item.id == selectedItem?.id, didTap: { [weak self] in
          if let selectableItem = item as? any ShapeItem & ShapeItemSelectable {
            self?.selectedItem = selectableItem
          }
        })
      }
  }
}
