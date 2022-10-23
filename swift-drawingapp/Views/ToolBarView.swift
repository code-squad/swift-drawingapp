//
//  ToolBarView.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import UIKit

protocol ToolBarViewDelegate: AnyObject {
    
    func toolBarView(_ toolBarView: ToolBarView, selectedToolInfo: ToolInfo)
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
            delegate?.toolBarView(self, selectedToolInfo: ToolInfo(type: "polygon"))
            
        case drawingButton:
            delegate?.toolBarView(self, selectedToolInfo: ToolInfo(type: "ink", options: ["width": 3, "color": "systemRed"]))
            
        default:
            break
        }
    }
}
