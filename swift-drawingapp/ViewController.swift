//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    private let rectButton: RectButton = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    private func setUI() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(rectButton)

        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
