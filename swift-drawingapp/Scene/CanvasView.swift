//
//  CanvasView.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import UIKit
import Combine

class CanvasView: UIView {
    
    private var viewModel: CanvasViewModel!
    private var shapeViews: [ObjectIdentifier: ShapeView] = [:]
    
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
    
    func setViewModel(_ viewModel: CanvasViewModel) {
        self.viewModel = viewModel
        viewModel.setSizeOfView(bounds.size)
        setupBindings()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewModel.setSizeOfView(bounds.size)
        viewModel.reloadCanvas()
    }
    
    // MARK: - Private
    
    private func setupBindings() {
        viewModel.$shapes
            .sink(receiveValue: updateShapeViews)
            .store(in: &cancelBag)
    }
    
    private func updateShapeViews(_ shapes: [ShapeViewModel]) {
        var shapeIDs = Array(shapeViews.keys)
        
        for shape in shapes {
            // 기존 Shape 뷰 업데이트
            if let index = shapeIDs.firstIndex(of: shape.id) {
                shapeViews[shape.id]?.updatePath(shape)
                shapeIDs.remove(at: index)
            }
            // 신규 Shape 뷰 생성
            else {
                let shapeView = makeShapeView(shape)
                addSubview(shapeView)
                shapeViews[shape.id] = shapeView
            }
        }
        
        // 제거된 Shape의 뷰 제거
        for id in shapeIDs {
            shapeViews[id]?.removeFromSuperview()
            shapeViews[id] = nil
        }
    }
    
    private func makeShapeView(_ shape: ShapeViewModel) -> ShapeView {
        let shapeView = ShapeView(frame: bounds)
        shapeView.updatePath(shape)
        return shapeView
    }
}
