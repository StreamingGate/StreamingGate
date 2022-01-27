//
//  ChatDataModel.swift
//  PlayGround
//
//  Created by chuiseo-MN on 2022/01/27.
//

import Foundation

struct ChatData: Codable {
    let chatType: String
    let message: String
    let nickname: String
    let roomId: String
    let senderRole: String
}