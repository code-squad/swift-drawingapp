//
//  DrawingAppModel.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class DrawingAppModel {
    
    @Published private(set) var canvas: Canvas = Canvas(size: .init(width: 500, height: 500))
    @Published private(set) var selectedShapeIDs: [UUID] = []
    @Published private(set) var receivedShapes: [any ShapeProtocol] = []
    
    private var chatClient: DrawingChatServiceProviding!
    
    func setChatServiceProvider(_ chatClient: DrawingChatServiceProviding) {
        self.chatClient = chatClient
    }
    
    enum Error: Swift.Error {
        case login
        case send
        case receive
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
            !(receivedShapes.contains { $0.id == selectedShape.id }) // 네트워크로 수신한 도형은 선택하지 못한다.
        else { return nil }
        
        if let index = (selectedShapeIDs.firstIndex { $0 == selectedShape.id }) {
            selectedShapeIDs.remove(at: index)
        } else {
            selectedShapeIDs.append(selectedShape.id)
        }
        return selectedShape
    }
    
    func startSynchronize() async throws {
//        do { try await chatClient.login() }
//        catch {
//            print("DrawingAppModel 로그인 오류", error)
//            throw Error.login
//        }
//
//        do { try await chatClient.sendShapes(canvas.shapes) }
//        catch {
//            print("DrawingAppModel 전송 오류", error)
//            throw Error.send
//        }
//
//        Task { @MainActor in
//            do {
//                for try await shapes in chatClient.shapeStream {
//                    shapes.forEach {
//                        canvas.addShape($0)
//                        receivedShapes.append($0)
//                    }
//                }
//            }
//            catch {
//                print("DrawingAppModel 수신 오류", error)
//                throw Error.receive
//            }
//        }
        
    }
}
