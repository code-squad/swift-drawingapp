//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//
import UIKit

protocol DrawingDisplayLogic: AnyObject {
    func disPlayNewSquareView(viewModel: Drawing.AddSquareEvent.ViewModel)
    func disPlayNewDrawView(viewModel: Drawing.DrawEvent.ViewModel)
}

final class DrawingViewController: UIViewController {
    lazy var addSquareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("사각형 추가", for: .normal)
        button.addAction(
            UIAction(handler: { [weak self] action in
                self?.touchedAddSquareButton(action)
            }),
            for: .touchDown)
        return button
    }()
    
    lazy var drawButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("그리기", for: .normal)
        button.addAction(
            UIAction(handler: { [weak self] action in
                self?.touchedDrawButton(action)
            }),
            for: .touchDown)
        return button
    }()
    
    var canvasView: CanvasView = CanvasView()
    
    var interactor: DrawingBusinessLogic?
    var router: (NSObjectProtocol & DrawingRoutingLogic & DrawingDataPassing)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = DrawingInteractor()
        let presenter = DrawingPresenter()
        let router = DrawingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

// MARK: UI + Event
extension DrawingViewController {
    private func setupUI() {
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [addSquareButton, drawButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        view.addSubview(stackView)
        view.addSubview(canvasView)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackViewConstraints = [stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                    stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        NSLayoutConstraint.activate(stackViewConstraints)
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        let canvasViewConstraints = [canvasView.topAnchor.constraint(equalTo: view.topAnchor),
                                     canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        NSLayoutConstraint.activate(canvasViewConstraints)
    }
    
    func touchedAddSquareButton(_ action: UIAction?) {
        let request = Drawing.AddSquareEvent.Request(bounds: self.canvasView.frame.size)
        interactor?.addSquare(request: request)
    }
    
    func touchedDrawButton(_ action: UIAction?) {
        let request = Drawing.DrawEvent.Request(bounds: self.canvasView.frame)
        interactor?.addLine(request: request)
    }
}

// MARK: Present
extension DrawingViewController: DrawingDisplayLogic {
    func disPlayNewDrawView(viewModel: Drawing.DrawEvent.ViewModel) {
        let drawView = DrawView(frame: viewModel.rect)
        drawView.lineColor = viewModel.color
        canvasView.addSubview(drawView)
    }
    
    func disPlayNewSquareView(viewModel: Drawing.AddSquareEvent.ViewModel) {
        let squareView = SquareView(frame: viewModel.rect)
        squareView.backgroundColor = viewModel.color
        canvasView.addSubview(squareView)
    }
}
