//
//  UIButton+Factory.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/16.
//

import UIKit

extension UIButton {
    static func create(title: String, selector: Selector) -> UIButton {
        let button: UIButton = .init()
        button.setTitle(title, for: .normal)
        button.addTarget(nil, action: selector, for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        return button
    }
}
