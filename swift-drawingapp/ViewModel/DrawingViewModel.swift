//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/15.
//

import Foundation
import QuartzCore

// 무슨 기준으로 나눈거니?
// 기대되는 출력값.
// viewModel에서 로직 처리 후 출력값을 전달하기 때문에, 기대되는 출력값들을 delegate로 정의하고 ViewController와 연결
protocol ViewModelDelegate: AnyObject {
    func selectSquare(square: Square)
    func drawSquare(square: Square, color: ColorAssets)
    func drawLine(line: Line, color: ColorAssets)
    func startLineDraw(line: Line, color: ColorAssets)
    func updateLineDraw(point: CGPoint)
    func endLineDraw()
}

enum DrawingMode {
    case square
    case line
}

protocol DrawingViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    func handleTouchesBegan(point: CGPoint)
    func handleTouchesMoved(point: CGPoint)
    func handleTouchesEnded()
    func handleSquareButtonSelected(rect: CGRect)
    func handleLineButtonSelected()
    func connectServer(id: String?)
}

class DrawingViewModel: DrawingViewModelProtocol {
    private let drawingStore: DrawingStoreProtocol
    private let drawingFactory: DrawingFactoryProtocol
    private var chatServerClient: ChatServerClientProtocol
    
    weak var delegate: ViewModelDelegate?
    
    var drawingMode: DrawingMode?
    
    init(
        drawingStore: DrawingStoreProtocol,
        drawingFactory: DrawingFactoryProtocol,
        chatServerClient: ChatServerClientProtocol
    ) {
        self.drawingStore = drawingStore
        self.drawingFactory = drawingFactory
        self.chatServerClient = chatServerClient
        
        self.chatServerClient.delegate = self
    }
    
    func handleTouchesBegan(point: CGPoint) {
        switch drawingMode {
        case .square:
            processRectSelection(point: point)
        case .line:
            let line = drawingFactory.startLinePoint(point: point)
            delegate?.startLineDraw(line: line, color: ColorAssets.randomColor())
        case .none:
            return
        }
    }
    
    func handleTouchesMoved(point: CGPoint) {
        if drawingMode == .line {
            drawingFactory.updateLinePoints(point: point)
            
            delegate?.updateLineDraw(point: point)
        }
    }
    
    func handleTouchesEnded() {
        if drawingMode == .line {
            let line = drawingFactory.endLinePoints()
            appendDrawing(shape: line)
            
            delegate?.endLineDraw()
        }
    }
    
    func handleSquareButtonSelected(rect: CGRect) {
        self.drawingMode = .square
        
        let square = drawingFactory.makeSquare(rect: rect)
        appendDrawing(shape: square)
        
        delegate?.drawSquare(square: square, color: ColorAssets.randomColor())
    }
    
    func handleLineButtonSelected() {
        self.drawingMode = .line
    }
    
    func connectServer(id: String?) {
        chatServerClient.login(id: id)
    }
    
    private func appendDrawing(shape: Shape) {
        drawingStore.appendData(data: shape)
    }
    
    private func processRectSelection(point: CGPoint) {
        if let square = findSquare(point: point) {
            delegate?.selectSquare(square: square)
        }
    }
    
    private func findSquare(point: CGPoint) -> Square? {
        let drawing = drawingStore.getData()
            .compactMap { $0 as? Square }
            .first { $0.isContain(point: point) }
        
        return drawing
    }
    
}

extension DrawingViewModel: ChatServerDelegate {
    func loginSucceed() {
        drawingStore.getData().forEach { shape in
            chatServerClient.sendData(shape: shape)
        }
    }
    
    func dataReceived(shape: Shape) {
        if let square = shape as? Square {
            delegate?.drawSquare(square: square, color: .systemGray)
        }
        if let line = shape as? Line {
            delegate?.drawLine(line: line, color: .systemGray)
        }
    }
}
