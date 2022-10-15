//
//  DrawingButton.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/15.
//

import UIKit

final class DrawingButton: UIButton {
    private let drawingView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.image = .init(systemName: "scribble")
        imageView.tintColor = .gray
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "드로잉"
        label.textColor = .gray
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor

        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(drawingView)
        stackView.addArrangedSubview(label)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            drawingView.widthAnchor.constraint(equalToConstant: 60),
            drawingView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
