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
    private let drawingButton: DrawingButton = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    private func setUI() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(rectButton)
        buttonStackView.addArrangedSubview(drawingButton)

        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        rectButton.addTarget(self, action: #selector(didTapRectButton), for: .touchUpInside)
    }

    @objc
    private func didTapRectButton() {
        addRectView()
    }

    private func addRectView() {
        let rect = rectProvider.createRect()

        let rectView = RectView(id: rect.id)
        rectView.frame = .init(
            origin: .random(in: view.frame),
            size: .init(width: 100, height: 100)
        )
        rectView.backgroundColor = .random
        rectView.addTarget(self, action: #selector(didTapRectView), for: .touchUpInside)
        view.addSubview(rectView)
    }

    @objc
    private func didTapRectView(sender: RectView) {
        sender.isSelected.toggle()
    }

    let rectProvider: RectProvidable

    init(rectProvider: RectProvidable) {
        self.rectProvider = rectProvider

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
