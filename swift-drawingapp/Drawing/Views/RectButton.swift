//
//  RectButton.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/15.
//

import UIKit

final class RectButton: UIButton {
    private let rectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "사각형"
        label.textColor = .gray
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.isUserInteractionEnabled = false
        return stackView
    }()

    override var isHighlighted: Bool {
        didSet {
            layer.borderColor = isHighlighted ? UIColor.systemRed.cgColor : UIColor.gray.cgColor
        }
    }

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
        stackView.addArrangedSubview(rectView)
        stackView.addArrangedSubview(label)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            rectView.widthAnchor.constraint(equalToConstant: 60),
            rectView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
