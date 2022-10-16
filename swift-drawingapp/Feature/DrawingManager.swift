//
//  DrawingManager.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/16.
//

import Foundation

class DrawingManager {
    private(set) var canvas: Canvas = Canvas(size: .init(width: 500, height: 500))
    private(set) var selectedShapes: [Shape] = []
    
    func createRandomRect() {
        let rectSize = Size(width: 100, height: 100)
        let originPoint = Point(
            x: Double.random(in: 0...canvas.size.width-rectSize.width),
            y: Double.random(in: 0...canvas.size.height-rectSize.height)
        )
        let rect = StyledRectangle(origin: originPoint, size: rectSize)
        rect.fillColor = Color.systemList.randomElement()
        canvas.addShape(rect)
    }
    
    func createDrawing(pointStream: AsyncStream<Point>) {
        Task { @MainActor in
            let drawing = StyledDrawing()
            drawing.lineColor = Color.systemList.randomElement()
            canvas.addShape(drawing)
            for await point in pointStream {
                drawing.addPoint(point)
            }
        }
    }
    
    /// 해당 지점에 있는 도형의 선택 상태를 토글한다.
    func selectShape(at point: Point) {
        guard let shape = canvas.findShape(at: point) else { return }
        if let index = (selectedShapes.firstIndex { $0 === shape }) {
            selectedShapes.remove(at: index)
        } else {
            selectedShapes.append(shape)
        }
    }
}



import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    
    var lastPoint: CGPoint!
    var linesize: CGFloat = 2.0
    var linecolor = UIColor.red.cgColor
        
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    @IBAction func clearImgView(_ sender: UIButton) {
        imgView.image = nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch //현재 발생한 터치 이벤트 가지고 옵니다
        lastPoint = touch.location(in: imgView) // 터치 된 위치를 lastPoint라는 변수에 저장합니다.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(linecolor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(linesize)
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) //이전에 이동된 위치인 lastpoint로 시작위치를 이동시킨다
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y)) //lastPoint에서 현재 위치는 currentPoint까지 선을 추가한다
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint //현재 터치 된 위치를 lastPoint라는 변수에 할당한다
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(linecolor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(linesize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

        }
        

