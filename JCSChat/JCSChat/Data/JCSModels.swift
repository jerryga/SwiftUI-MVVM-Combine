//
//  JCSModels.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import Foundation

struct JCSConversation: Codable, Identifiable {
    var id: String = "conversation" + UUID().uuidString
    var chatPartner: JCSUser
    var messages: [JCSMessage] = []
    var lastestMessage: JCSMessage? {
        return messages.last
    }
}

struct JCSUser: Codable, Identifiable{
    var id: String = "userId" + UUID().uuidString
    var name: String
}

struct JCSMessage: Codable, Identifiable {
    var id: String = "messageId" + UUID().uuidString
    var content: String
    var date: Date = Date()
    var user: JCSUser
}

extension JCSMessage {
    var isCurrentUser: Bool {
        return self.user.id == JCSMockDataSource.currentUser.id
    }
}


struct JCSMockDataSource  {
    
    static let currentUser = JCSUser.init(name: "Asa")

    static let friends = [
        JCSUser.init(name: "Jone"),
        JCSUser.init(name: "Kent"),
    ]
    
    static var conversations = [
        JCSConversation.init(chatPartner: friends[0], messages: [JCSMessage.init(content: "How are you?", user: currentUser),
                                                                 JCSMessage.init(content: "How are you?", user: friends[0])
                                                                ]),
        JCSConversation.init(chatPartner: friends[1], messages: [JCSMessage.init(content: "Hello", user: friends[1])]),

    ]

}

