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
    private var shapeViews: [ShapeView] = []
    
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
        // TODO: 뷰를 지우고 다시 넣지 않고 업데이트 하도록 변경하기
        shapeViews.forEach { $0.removeFromSuperview() }
        shapeViews = []
        
        shapes.forEach { shape in
            let shapeView = makeShapeView(shape)
            addSubview(shapeView)
            shapeViews.append(shapeView)
        }
    }
    
    private func makeShapeView(_ shape: ShapeViewModel) -> ShapeView {
        let shapeView = ShapeView(frame: bounds)
        shapeView.updatePath(shape)
        return shapeView
    }
}
