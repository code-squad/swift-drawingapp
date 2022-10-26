//
//  DrawingManager.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class DrawingManager {
    private(set) var canvas: Canvas = Canvas(size: .init(width: 500, height: 500))
    private(set) var selectedShapes: [Shape] = [] {
        didSet { delegate?.selectedShapesChanged(selectedShapes) }
    }
    private(set) var receivedShapes: [Shape] = [] {
        didSet { delegate?.receivedShapesChanged(receivedShapes) }
    }
    
    private var chatClient: DrawingChatServiceProviding!
    
    weak var delegate: DrawingManagerDelegate?
    
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
        let rect = StyledRectangle(origin: originPoint, size: rectSize)
        rect.fillColor = Color.systemList.randomElement()
        canvas.addShape(rect)
    }
    
    func createDrawing(pointStream: AsyncStream<Point>) {
        Task { @MainActor in
            let drawing = StyledDrawing()
            drawing.lineColor = Color.systemList.randomElement()
            canvas.addShape(drawing)
            for await point in pointStream {
                drawing.addPoint(point)
            }
        }
    }
    
    /// 해당 지점에 있는 도형의 선택 상태를 토글한다.
    @discardableResult
    func selectShape(at point: Point) -> Shape? {
        guard
            let shape = canvas.findShape(at: point),
            !receivedShapes.contains(shape)
        else { return nil }
        
        if let index = (selectedShapes.firstIndex { $0 === shape }) {
            selectedShapes.remove(at: index)
        } else {
            selectedShapes.append(shape)
        }
        return shape
    }
    
    func startSynchronize() async throws {
        do { try await chatClient.login() }
        catch {
            print("DrawingManager 로그인 오류", error)
            throw Error.login
        }
        
        try! await Task.sleep(nanoseconds: 1000000000)
        
        do { try await chatClient.sendShapes(canvas.shapes) }
        catch {
            print("DrawingManager 전송 오류", error)
            throw Error.send
        }
        
        Task { @MainActor in
            do {
                for try await shapes in chatClient.shapeStream {
                    shapes.forEach {
                        canvas.addShape($0)
                        receivedShapes.append($0)
                    }
                }
            }
            catch {
                print("DrawingManager 수신 오류", error)
                throw Error.receive
            }
        }
        
    }
}

protocol DrawingManagerDelegate: AnyObject {
    func selectedShapesChanged(_ selectedShapes: [Shape])
    func receivedShapesChanged(_ receivedShapes: [Shape])
}
