//
//  CanvasViewModel.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/18.
//

import Foundation

class CanvasViewModel:
    PolygonDrawingUseCase,
    InkDrawingUseCase,
    ToolSelectionUseCase,
    ItemSelectionUseCase,
    SelectionOrDrawingUseCase,
    SyncUseCase
{
    
    private(set) var drawing: Drawing
    
    private(set) var selectedTool: Tool
    
    private(set) var currentDrawingStroke: Stroke?
    
    private(set) var currentLoggedInUser: User?
    
    private weak var polygonDrawingPort: PolygonDrawingPresenterPort?
    
    private weak var inkDrawingPort: InkDrawingPresenterPort?
    
    private weak var toolSelectionPort: ToolSelectionPresenterPort?
    
    private weak var itemSelectionPort: ItemSelectionPresenterPort?
    
    private weak var chatRepositoryPort: ChatRepositoryPort?
    
    init(
        drawing: Drawing = .init(),
        selectedTool: Tool = PolygonTool()
    ) {
        self.drawing = drawing
        self.selectedTool = selectedTool
        NotificationCenter.default.addObserver(self, selector: #selector(receive(_:)), name: .chatViewModel, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .chatViewModel, object: nil)
    }
}

// MARK: - PolygonDrawingUseCase

extension CanvasViewModel {
    
    func draw(tool: Tool, layoutInfo: LayoutInfo?, uiInfo: UIInfo?) -> Drawing {
        guard tool is PolygonTool else { return drawing }
        update(drawing, rectangle: create(point: layoutInfo?.center))
        polygonDrawingPort?.update(drawing: drawing)
        return drawing
    }
    
    func create(point: Point?) -> Rectangle {
        return Rectangle(
            layoutInfo: .init(size: Size(width: 100, height: 100), center: point),
            uiInfo: .init(backgroundColor: randomSystemColorName, borderColor: "clear", borderWidth: 3.0)
        )
    }
    
    func update(_ drawing: Drawing, rectangle: Rectangle) {
        drawing.items[rectangle.id] = rectangle
    }
    
    func setPresenter(with port: PolygonDrawingPresenterPort) {
        polygonDrawingPort = port
    }
}

// MARK: - InkDrawingUseCase

extension CanvasViewModel {
    
    func draw(tool: Tool, beganAt: Point) -> Drawing {
        guard let inkTool = tool as? InkTool else { return drawing }
        update(drawing, stroke: create(positions: [beganAt], ink: inkTool.ink))
        inkDrawingPort?.update(drawing: drawing)
        return drawing
    }
    
    func draw(tool: Tool, valueChangedAt: Point) -> Drawing {
        guard tool is InkTool, let stroke = currentDrawingStroke else { return drawing }
        update(drawing, stroke: stroke, points: [valueChangedAt])
        inkDrawingPort?.update(drawing: drawing)
        return drawing
    }
    
    func draw(tool: Tool, endedAt: Point) -> Drawing {
        guard tool is InkTool, let stroke = currentDrawingStroke else { return drawing }
        update(drawing, stroke: stroke, points: [endedAt])
        reset()
        inkDrawingPort?.update(drawing: drawing)
        return drawing
    }
    
    func create(positions: [Point], ink: Ink) -> Stroke {
        return .init(positions: positions, ink: ink)
    }
    
    func update(_ drawing: Drawing, stroke: Stroke) {
        drawing.items[stroke.id] = stroke
        currentDrawingStroke = stroke
    }
    
    func update(_ drawing: Drawing, stroke: Stroke, points: [Point]) {
        let newStroke = Stroke(
            id: stroke.id,
            positions: stroke.points + points,
            ink: stroke.ink
        )
        drawing.items[stroke.id] = newStroke
        currentDrawingStroke = newStroke
    }
    
    func reset() {
        currentDrawingStroke = nil
    }
    
    func setPresenter(with port: InkDrawingPresenterPort) {
        inkDrawingPort = port
    }
}

// MARK: - ToolSelectionUseCase

extension CanvasViewModel {
    
    func select(toolInfo: ToolInfo) -> Tool {
        var tool: Tool = PolygonTool()
        
        switch toolInfo.type {
        case "polygon":
            tool = PolygonTool()
            
        case "ink":
            if let lineWidth = toolInfo.options?["width"] as? Double,
               let lineColor = toolInfo.options?["color"] as? String {
                tool = InkTool(ink: Ink(lineWidth: lineWidth, lineColor: lineColor))
            } else {
                tool = InkTool(ink: Ink(lineWidth: 3, lineColor: "systemBlue"))
            }
            
        case "sync":
            tool = SyncTool()
            
        default:
            tool = PolygonTool()
        }
        selectedTool = tool
        toolSelectionPort?.update(tool: tool)
        return tool
    }
    
    func setPresenter(with port: ToolSelectionPresenterPort) {
        toolSelectionPort = port
    }
}

// MARK: - ItemSelectionUseCase

extension CanvasViewModel {
    
    func select(_ drawing: Drawing, item: Item) -> Drawing.DataType {
        if let item = drawing.selectedItems[item.id] {
            drawing.selectedItems[item.id] = nil
        } else {
            drawing.selectedItems[item.id] = item
        }
        itemSelectionPort?.update(selectedItems: drawing.selectedItems)
        return drawing.selectedItems
    }
    
    func find(items: [Item], point: Point) -> Item? {
        guard let item = items.first(where: { $0.frame.contains(point.toCGPoint) }) else { return nil }
        return item
    }
    
    func setPresenter(with port: ItemSelectionPresenterPort) {
        itemSelectionPort = port
    }
}

// MARK: - SelectionOrDrawingUseCase

extension CanvasViewModel {
    
    func selectOrDraw(items: [Item], point: Point) {
        if let item = find(items: items, point: point) {
            itemSelectionPort?.update(selectedItems: select(drawing, item: item))
        } else {
            let drawing = draw(tool: selectedTool, layoutInfo: .init(center: point), uiInfo: nil)
            polygonDrawingPort?.update(drawing: drawing)
        }
    }
}

// MARK: - SyncUseCase

extension CanvasViewModel {
    
    func create(id: String) -> User {
        return User(id: id)
    }
    
    /// 로그인 응답을 받으면 그린 도형을 모두 서버에 전달한다
    func login(user: User, drawing: Drawing) {
        currentLoggedInUser = user
        let data = UserCommand(header: "0x10", id: user.id, drawing: drawing.items)
        NotificationCenter.default.addObserver(self, selector: #selector(receive(_:)), name: Notification.Name(user.id), object: nil)
        NotificationCenter.default.post(name: .chatServer, object: nil, userInfo: ["data": data, "client": user.id])
    }
    
    /// 로그아웃시 응답을 받지 않는다
    func logout(user: User) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(user.id), object: nil)
    }
    
    /// 채팅을 시작하면, 서버에서 다른 사람의 도형 데이터를 받고 해당 도형을 다른 시스템 컬러로 그린다
    func start(by user: User?) {
        guard let user = user else { return }
        let data = UserCommand(header: "0x20", id: user.id, drawing: nil)
        NotificationCenter.default.post(name: .chatServer, object: nil, userInfo: ["data": data, "client": user.id])
    }
    
    @objc
    private func receive(_ notification: Notification) {
        guard let response = notification.userInfo?["response"] as? CommandResponse else { return }
        switch response.header {
        case "0x11":
            break
            
        case "0x21":
            guard let drawings = response.drawing else { return }
            var results: Drawing.DataType = [:]
            drawings.forEach { items in
                items.forEach { item in
                    item.value.uiInfo?.backgroundColor = randomSystemColorName
                    results[item.key] = item.value
                }
            }
            polygonDrawingPort?.update(drawing: Drawing(items: results))
            
        default:
            break
        }
    }
    
    func setRespository(with port: ChatRepositoryPort) {
        chatRepositoryPort = port
    }
}
