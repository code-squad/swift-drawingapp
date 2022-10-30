//
//  Rectangle.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/23.
//

import Foundation

final class Rectangle: Item {

    init(id: String = UUID().uuidString, layoutInfo: LayoutInfo = .init(), uiInfo: UIInfo = .init()) {
        super.init(id: id, layoutInfo: layoutInfo, uiInfo: uiInfo)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case layoutInfo
        case uiInfo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        let id = (try? container?.decodeIfPresent(String.self, forKey: .id)) ?? UUID().uuidString
        let layoutInfo = try? container?.decodeIfPresent(LayoutInfo.self, forKey: .layoutInfo)
        let uiInfo = try? container?.decodeIfPresent(UIInfo.self, forKey: .uiInfo)
        super.init(id: id, layoutInfo: layoutInfo, uiInfo: uiInfo)
    }
    
//    override var toJSON: String {
//        """
//        {
//            "id": "\(id)",
//            "layoutInfo": {
//                "size": { "width": \(layoutInfo?.size?.width ?? 0), "height": \(layoutInfo?.size?.height ?? 0)}
//                "center": { "x": \(layoutInfo?.center?.x ?? 0), "y": \(layoutInfo?.center?.y ?? 0) }
//            },
//            "uiInfo": {
//                
//            }
//        }
//        """
//    }
}
