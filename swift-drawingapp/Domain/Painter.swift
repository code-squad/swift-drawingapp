//
//  Painter.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/29.
//

import Foundation

class Painter {
    private weak var presenterPort: (DrawPresenterOutPort & TouchPresenterOutPort)?
    private weak var dataPort: (DataOutPort)?

    private var pictures: [Picture] = []

    func setPresenterPort(_ presenterPort: (DrawPresenterOutPort & TouchPresenterOutPort)) {
        self.presenterPort = presenterPort
    }

    func setDataPort(_ dataPort: DataOutPort) {
        self.dataPort = dataPort
    }
}

// MARK: - SyncUseCase
extension Painter: SyncUseCase {
    func syncAll() {
        Task {
            guard await dataPort?.login() ?? false else { return }
            dataPort?.sendPictures(pictures)
        }
    }
}

extension Painter: DataInPort {
    func addPictures(_ pictures: [Picture]) {
        self.pictures.append(contentsOf: pictures)
    }
}

// MARK: - TouchUseCase
extension Painter: TouchUseCase {
    func touch(index: Int, coordinate: Point?) {
        let picture = pictures[index]
        picture.selected(on: coordinate)
        presenterPort?.touch(index: index, at: coordinate)
    }
}

// MARK: - DrawUseCase
extension Painter: DrawUseCase {
    func drawRectangle(inside area: Area) {
        let rectangle = Rectangle(
            color: Color.randomColor,
            points: area.randomRectangle(width: 100, height: 100),
            lineWidth: 4
        )
        pictures.append(rectangle)
        presenterPort?.drawRectangle(with: rectangle)
    }

    func readyDrawingCanvas() {
        let drawing = Drawing(color: Color.randomColor, points: [], lineWidth: 8)
        pictures.append(drawing)
        presenterPort?.readyDrawingCanvas(with: drawing)
    }
}
fileprivate extension Area {
    func randomRectangle(width: Double, height: Double) -> [Point] {
        let origin: Point = .init(
            x: Double.random(in: 0..<(self.size.width - width)),
            y: Double.random(in: 0..<(self.size.height - height))
        )
        return [
            origin,
            .init(x: origin.x + width, y: origin.y),
            .init(x: origin.x, y: origin.y + height),
            .init(x: origin.x + width, y: origin.y + height),
        ]
    }
}
