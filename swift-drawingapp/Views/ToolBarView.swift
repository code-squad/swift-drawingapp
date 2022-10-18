//
//  ToolBarView.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

protocol ToolBarViewDelegate: AnyObject {
    
    func toolBarView(_ toolBarView: ToolBarView, selectedTool: Tool)
}

final class ToolBarView: UIView {
    
    weak var delegate: ToolBarViewDelegate?
    
    @IBOutlet private weak var rectangleButton: UIButton! {
        willSet {
            newValue.layer.borderColor = UIColor.black.cgColor
            newValue.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet private weak var drawingButton: UIButton! {
        willSet {
            newValue.layer.borderColor = UIColor.black.cgColor
            newValue.layer.borderWidth = 0.5
        }
    }
    
    @IBAction func didTapButton(sender: UIButton) {
        switch sender {
        case rectangleButton:
            delegate?.toolBarView(self, selectedTool: PolygonTool())
            
        case drawingButton:
            delegate?.toolBarView(self, selectedTool: InkTool(ink: Ink(lineWidth: 3, lineColor: "systemRed")))
            
        default:
            break
        }
    }
}
