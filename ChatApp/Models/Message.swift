//
//  Message.swift
//  ChatApp
//
//  Created by 株丹優一郎 on 2024/06/22.
//

import Foundation

struct Message: Decodable, Identifiable {
    let id: String
    let text: String
    let user: User
    let date: String
    let readed: Bool
}
