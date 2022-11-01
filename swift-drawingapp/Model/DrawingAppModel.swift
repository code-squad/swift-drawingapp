//
//  DrawingAppModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation
import Combine

class DrawingAppModel {
    
    @Published private(set) var canvas: Canvas = Canvas(size: .init(width: 500, height: 500))
    let selectedShapeIDs: CurrentValueSubject<[UUID], Never> = .init([])
    let receivedShapes: CurrentValueSubject<[any ShapeProtocol], Never> = .init([])
    
    private var chatClient: DrawingChatServiceProviding!
    
    func setChatServiceProvider(_ chatClient: DrawingChatServiceProviding) {
        self.chatClient = chatClient
    }
    
    func createRandomRect() {
        let rectSize = Size(width: 100, height: 100)

        var availableOriginBounds = canvas.size
        availableOriginBounds.width -= rectSize.width
        availableOriginBounds.height -= rectSize.height

        let originPoint = Point.random(in: availableOriginBounds)
        let rect = Rectangle(origin: originPoint, size: rectSize, fillColor: Color.systemList.randomElement())
        canvas.addShape(rect)
    }
    
    func createDrawing(pointStream: AnyAsyncSequence<Point>) {
        Task { @MainActor in
            let drawing = Path(points: [], lineColor: Color.systemList.randomElement())
            canvas.addShape(drawing)
            
            do {
                for try await point in pointStream {
                    canvas.transformShape(id: drawing.id) { shape in
                        var path = shape as! Path
                        path.addPoint(point)
                        return path
                    }
                }
            } catch { fatalError() }
        }
    }
    
    /// 해당 지점에 있는 도형의 선택 상태를 토글한다.
    @discardableResult
    func selectShape(at point: Point) -> (any SelectableShape)? {
        guard
            let selectedShape = canvas.findShape(at: point),
            !(receivedShapes.value.contains { $0.id == selectedShape.id }) // 네트워크로 수신한 도형은 선택하지 못한다.
        else { return nil }
        
        if let index = (selectedShapeIDs.value.firstIndex { $0 == selectedShape.id }) {
            selectedShapeIDs.value.remove(at: index)
        } else {
            selectedShapeIDs.value.append(selectedShape.id)
        }
        return selectedShape
    }
    
    func startSynchronize() async throws {
        try await chatClient.login()
        try await chatClient.sendShapes(Array(canvas.shapes))

        Task { @MainActor in
            for try await shapes in chatClient.shapeStream {
                shapes.forEach { shapeData in
                    let shape = Shape(points: shapeData, fillColor: .yellow, lineColor: .blue)
                    canvas.addShape(shape)
                    receivedShapes.value.append(shape)
                }
            }
        }
        
    }
}
