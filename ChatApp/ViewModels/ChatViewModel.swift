//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by 株丹優一郎 on 2024/06/22.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var chatData: [Chat] = []
    
    init() {
        chatData = fetchChatData()
    }
    
    private func fetchChatData() -> [Chat] {
        let fileName = "chatData.json"
        let data: Data
        
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("\(fileName)が見つかりませんでした")
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("\(fileName)のロードに失敗しました")
        }
        
        do {
            return try JSONDecoder().decode([Chat].self, from: data)
        } catch {
            fatalError("\(fileName)を\(Chat.self)に変換することに失敗しました")
        }
    }
    
    func addMessage(chatId: String, text: String) {
        
        guard let index = chatData.firstIndex(where: { chat in
            chat.id == chatId
        }) else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateString = formatter.string(from: Date())
        
        let newMessage = Message(
            id: UUID().uuidString,
            text: text,
            user: User.currentUser,
            date: formattedDateString,
            readed: false
        )
        
        chatData[index].messages.append(newMessage)
    }
    
    func getTitle(messages: [Message]) -> String {
        
        var title = ""
        var userIds: [String] = []
        
        for message in messages {
            let id = message.user.id
            
            if id == User.currentUser.id { continue }
            if userIds.contains(id) { continue }
            
            userIds.append(id)
            
            let name = message.user.name
            title += title.isEmpty ? "\(name)" : ",\(name)"
        }
        
        return title
    }
}
