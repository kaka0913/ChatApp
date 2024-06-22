//
//  ListView.swift
//  ChatApp
//
//  Created by 株丹優一郎 on 2024/06/22.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var vm: ChatViewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                header
                
                // List
                list
            }
            .padding(.horizontal)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

extension ListView {
    
    private var header: some View {
        HStack {
            Text("トーク")
                .font(.title2.bold())
            
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "text.badge.checkmark")
                Image(systemName: "square")
                Image(systemName: "ellipsis.bubble")
            }
            .font(.title2)
        }
    }
    
    private var list: some View {
        ScrollView {
            VStack {
                ForEach(vm.chatData) { chat in
                    NavigationLink {
                        ChatView(chat: chat)
                            .environmentObject(vm)
                            .toolbar(.hidden)
                    } label: {
                        listRow(chat: chat)
                    }
                }
            }
        }
    }
    
    private func listRow(chat: Chat) -> some View {
        HStack {
            Image("user01")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("タイトル")
                    .foregroundColor(.primary)
                Text(chat.recentMessageText)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Text("12/31")
                .font(.caption)
                .foregroundColor(Color(uiColor: .secondaryLabel))
        }
    }
}
