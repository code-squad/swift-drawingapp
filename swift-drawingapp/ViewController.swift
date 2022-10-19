//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var canvasImageView: UIImageView!
    @IBOutlet var tmpImageView: UIImageView!
    
    @IBOutlet var rectangleButton: UIButton!
    @IBOutlet var drawingButton: UIButton!
    var drawingPoints: [CGPoint] = []
    var strokeColor: CGColor = ColorSet.randomColor.cgColor
    var lastPoint: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func rectangleButtonClicked(_ sender: UIButton) {
        let width: CGFloat = 100.0
        let height: CGFloat = 100.0
        let rect =  CGRect(x: CGFloat.random(in: 0 ..< view.bounds.width - width),
                           y: CGFloat.random(in: 0 ..< view.bounds.height - height),
                           width: width,
                           height: height)
        let rectView = UIView(frame: rect)
        
        rectView.backgroundColor = ColorSet.randomColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchAction(_:)))
        rectView.addGestureRecognizer(tapGesture)
        canvasImageView.isUserInteractionEnabled = true
        canvasImageView.addSubview(rectView)
    }
    
    @objc func touchAction(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        
        if view.layer.borderWidth == 0 {
            view.layer.borderWidth = 10
            view.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            view.layer.borderWidth = 0
            view.layer.borderColor = nil
        }
    }
    
    @IBAction func drawingButtonClicked(_ sender: UIButton) {
        drawingButton.isSelected = drawingButton.isSelected == false
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        draw(on: canvasImageView)
    }
    
    func draw(on view: UIImageView) {
        guard drawingButton.isSelected else { return }
        let drawingView = UIImageView(frame: self.view.frame)
        UIGraphicsBeginImageContext(drawingView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.move(to: drawingPoints[0])
        context.addLine(to: drawingPoints[0])
        
        for i in 0 ..< drawingPoints.count - 1 {
            drawingView.image?.draw(in: self.view.bounds)
            
            context.move(to: drawingPoints[i])
            context.addLine(to: drawingPoints[i + 1])
        }
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(10.0)
        context.setStrokeColor(strokeColor)
        context.strokePath()

        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        view.addSubview(drawingView)
        UIGraphicsEndImageContext()
        
        tmpImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard drawingButton.isSelected else { return }
        strokeColor = ColorSet.randomColor.cgColor
        guard let touch = touches.first else { return }

        drawingPoints = []
        drawingPoints.append(touch.location(in: view))
        
        lastPoint = touch.location(in: view)
        draw(from: lastPoint, to: lastPoint)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard drawingButton.isSelected else { return }
        guard let touch = touches.first else { return }

        drawingPoints.append(touch.location(in: view))
        
        let currentPoint = touch.location(in: view)
        draw(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    func draw(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        tmpImageView.image?.draw(in: view.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(10.0)
        context.setStrokeColor(strokeColor)
        context.strokePath()
        
        tmpImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    
}
