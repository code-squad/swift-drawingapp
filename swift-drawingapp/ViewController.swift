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
    
    var strokeColor: UIColor?
    var lastPoint: CGPoint = CGPoint.zero
    var isBeingSwiped: Bool = false
    var shape: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectangleButton.isSelected = true
        shape = "rectangle"
    }
    
    @IBAction func rectangleButtonClicked(_ sender: UIButton) {
        rectangleButton.isSelected = true
        drawingButton.isSelected = false
        shape = "rectangle"
    }
    
    @IBAction func drawingButtonClicked(_ sender: UIButton) {
        rectangleButton.isSelected = false
        drawingButton.isSelected = true
        shape = "drawing"
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        canvasImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        strokeColor = ColorSet.randomColor

        guard let touch = touches.first else { return }

        isBeingSwiped = false
        lastPoint = touch.location(in: view)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        isBeingSwiped = true

        let currentPoint = touch.location(in: view)

        if shape == "rectangle" {
            tmpImageView.image = nil
            draw(from: lastPoint, to: currentPoint)
        } else if shape == "drawing" {
            draw(from: lastPoint, to: currentPoint)
            lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isBeingSwiped == false {
            draw(from: lastPoint, to: lastPoint)
        }
        UIGraphicsBeginImageContext(canvasImageView.frame.size)
        canvasImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tmpImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        tmpImageView.image = nil
    }
    
    func draw(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext(),
              let strokeColor = strokeColor else { return }
        tmpImageView.image?.draw(in: view.bounds)
        
        if shape == "rectangle" {
            let rect =  CGRect(x: fromPoint.x,
                               y: fromPoint.y,
                               width: toPoint.x - fromPoint.x,
                               height: toPoint.y - fromPoint.y)
            context.addRect(rect)
        } else if shape == "drawing" {
            context.move(to: fromPoint)
            context.addLine(to: toPoint)
        }
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(10.0)
        context.setStrokeColor(strokeColor.cgColor)
        context.strokePath()
        
        tmpImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
