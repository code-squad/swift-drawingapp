//
//  DummySocket.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/25.
//

import Foundation
import CoreGraphics

protocol DummySocketProtocol {
    func login()
    func sendData(data: Data)
}

protocol DummyScoketDelegate: AnyObject {
    func pushData(data: Data?)
}

class DummySocket: DummySocketProtocol {

    var timer: Timer?
    
    var dummyDatas: [Command] = [
        Command(header: "0x20",
                id: "square",
                data: Square(points: [
                    CGPoint(x: 8, y:798),
                    CGPoint(x: 8, y:898),
                    CGPoint(x: 108, y:898),
                    CGPoint(x: 108, y:798),
                    CGPoint(x: 8, y:798),
                ]).toJsonData()),
        Command(header: "0x20",
                id: "square",
                data: Square(points: [
                    CGPoint(x: 308, y:874),
                    CGPoint(x: 308, y:974),
                    CGPoint(x: 408, y:974),
                    CGPoint(x: 408, y:874),
                    CGPoint(x: 308, y:874),
                ]).toJsonData()),
        Command(header: "0x20",
                id: "line",
                data: Line(points: [
                    CGPoint(x: 568, y:470),
                    CGPoint(x: 569, y:466),
                    CGPoint(x: 571, y:451),
                    CGPoint(x: 583, y:436),
                    CGPoint(x: 585, y:435),
                ]).toJsonData()),
        Command(header: "0x20",
                id: "line",
                data: Line(points: [
                    CGPoint(x: 80, y:78),
                    CGPoint(x: 80, y:150),
                    CGPoint(x: 85, y:120),
                    CGPoint(x: 90, y:190),
                    CGPoint(x: 100, y:100),
                ]).toJsonData()),
    ]
    
    weak var delegate: DummyScoketDelegate?

    init() {
        
    }
    
    func login() {
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    func sendData(data: Data) {
        //
    }
    
    @objc func fire()
    {
        if dummyDatas.isEmpty {
            timer?.invalidate()
            return
        }
        let data = dummyDatas.removeFirst().toJsonData()
        delegate?.pushData(data: data)
    }
}
