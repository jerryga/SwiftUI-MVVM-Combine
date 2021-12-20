//
//  JCSUserService.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import Foundation
import Combine

protocol JCSConversationsServiceProtocol: AnyObject {
    func fetchConversations(for user: JCSUser) -> AnyPublisher<[JCSConversation], Error>
    func sendMessage(_ message: JCSMessage, to conversation: JCSConversation) -> AnyPublisher<[JCSConversation], Error>

}

final class JCSConversationsService: JCSConversationsServiceProtocol {
    
    let dbRepository: JCSConversationsRepositoryProtocol
    
    init(dbRepository: JCSConversationsRepositoryProtocol = JCSConversationsRepository()) {
        self.dbRepository = dbRepository;
    }
    func fetchConversations(for user: JCSUser) -> AnyPublisher<[JCSConversation], Error> {
        return self.dbRepository.fetchConversations(for: user)
    }
    
    func sendMessage(_ message: JCSMessage, to conversation: JCSConversation) -> AnyPublisher<[JCSConversation], Error> {
        return self.dbRepository.sendMessage(message, to: conversation)
    }

}
