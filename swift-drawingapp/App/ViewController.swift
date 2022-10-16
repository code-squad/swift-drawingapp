//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redView = UIView()
        redView.backgroundColor = .red
        redView.frame = .init(origin: .init(x: 100, y: 100), size: .init(width: 250, height: 350))
        
        view.addSubview(redView)
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        yellowView.frame = .init(origin: .init(x: 10, y: 10), size: .init(width: 30, height: 60))
        
        redView.addSubview(yellowView)
    }


}

