//
//  Chat.swift
//  ChatApp
//
//  Created by 株丹優一郎 on 2024/06/22.
//

import Foundation

struct Chat: Decodable, Identifiable {
    let id: String
    var messages: [Message]
    
    var recentMessageText: String {
        guard let recentMessge = self.messages.last else {return ""}
        
        return recentMessge.text
    }
    
    var recentMessageDateString: String {
        guard let recentMessage = self.messages.last else { return ""}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: recentMessage.date) else { return "" }
        formatter.dateFormat = "MM/dd"
        
        return formatter.string(from: date)
    }
}
