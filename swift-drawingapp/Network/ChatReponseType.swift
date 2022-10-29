//
//  ChatReponseType.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/29.
//

import Foundation

enum ChatResponseType: String {
    case loginSucceed = "0x11"
    case shapePushed = "0x20"
}

enum ChatRequestTyoe: String {
    case login = "0x10"
    case chat = "0x20"
}
