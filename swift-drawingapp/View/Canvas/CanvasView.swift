//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit
import Combine

class CanvasView: UIView {
    
    private var canvasModel: CanvasViewRepresentable!
    private var shapeViews: [UUID: ShapeView] = [:]
    
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .white
    }
    
    // MARK: - Setter
    
    func setCanvasModel(_ canvasModel: CanvasViewRepresentable) {
        self.canvasModel = canvasModel
        self.canvasModel.setSizeOfView(bounds.size)
        
        setupStates()
    }
    
    // MARK: - Private
    
    private func setupStates() {
        cancelBag = []
        canvasModel.shapes
            .sink(receiveValue: updateShapeViews)
            .store(in: &cancelBag)
    }
    
    private func updateShapeViews(_ shapes: [(UUID, ShapeViewRepresentable)]) {
        let shapes = shapes.map { id, shape in
            (id, canvasModel.transformShape(id, shape))
        }
        
        var shapeIDs = Array(shapeViews.keys)
        
        for (id, shape) in shapes {
            // 기존 Shape 뷰 업데이트
            if let index = shapeIDs.firstIndex(of: id) {
                shapeViews[id]?.updateShape(shape)
                shapeIDs.remove(at: index)
            }
            // 신규 Shape 뷰 생성
            else {
                let shapeView = createShapeView(shape)
                addSubview(shapeView)
                shapeViews[id] = shapeView
            }
        }
        
        // 제거된 Shape의 뷰 제거
        for id in shapeIDs {
            shapeViews[id]?.removeFromSuperview()
            shapeViews[id] = nil
        }
    }
    
    private func createShapeView(_ shape: ShapeViewRepresentable) -> ShapeView {
        let shapeView = ShapeView(frame: bounds)
        shapeView.updateShape(shape)
        return shapeView
    }
}
