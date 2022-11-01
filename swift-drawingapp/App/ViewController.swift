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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let drawingVC = DrawingAppViewController()
        drawingVC.modalPresentationStyle = .fullScreen
        present(drawingVC, animated: false)
    }
}
