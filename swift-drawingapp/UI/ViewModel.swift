//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by 최동규 on 2022/10/18.
//

import Foundation
import Combine
import UIKit

final class ViewModel {


    struct Action {
        let addRectangle = PassthroughSubject<Void, Never>()
        let selectObject = PassthroughSubject<DrawingObject, Never>()
        let addObject = PassthroughSubject<DrawingObject, Never>()
    }

    struct State {
        let drawingObjects = CurrentValueSubject<[DrawingObject], Never>([])
        let canvasRect = CurrentValueSubject<CGRect?, Never>(nil)
    }

 

    let action : Action = Action()
    let state : State = State()
    private var cancellables = Set<AnyCancellable>()

    init() {
        action.addRectangle
            .sink { [weak self] _ in
                guard let self = self,
                      let canvasRect = self.state.canvasRect.value else { return }
                let position =  CGPoint(x: CGFloat.random(in: (canvasRect.origin.x...(canvasRect.size.width - Rectangle.defaultSize.width))) , y:  CGFloat.random(in: (canvasRect.origin.y...(canvasRect.size.height - Rectangle.defaultSize.height))))
                let rectangle = Rectangle(origin: position, size: Rectangle.defaultSize, color: .randomColor.withAlphaComponent(0.3))
                var objects = self.state.drawingObjects.value
                objects.append(rectangle)
                self.state.drawingObjects.send(objects)
            }
            .store(in: &cancellables)

        action.selectObject
            .sink { [weak self] object in

                guard let self = self  else { return }

                let objects = self.state.drawingObjects.value
                let newObjects = objects.map { element -> DrawingObject in
                    var newObject = element
                    newObject.isSelected = object.identifier == newObject.identifier && !newObject.isSelected
                    return newObject
                }
                self.state.drawingObjects.send(newObjects)
            }
            .store(in: &cancellables)

        action.addObject
            .sink { [weak self] object in

                guard let self = self  else { return }

                var newObjects = self.state.drawingObjects.value
                if let index = newObjects.firstIndex(where: { $0.identifier == object.identifier }) {
                    newObjects[index] = object
                } else {
                    newObjects.append(object)
                }
                self.state.drawingObjects.send(newObjects)
            }
            .store(in: &cancellables)
    }
}
