//
//  DrawingTypeButton.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/16.
//

import UIKit

class DrawingTypeButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .lightGray
        } else {
            self.backgroundColor = .white
        }
    }
}
