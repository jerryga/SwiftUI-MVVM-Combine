//
//  JCSFriendsRepository.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import Foundation
import Combine

protocol JCSConversationsRepositoryProtocol {
    func fetchConversations(for user: JCSUser) -> AnyPublisher<[JCSConversation], Error>
    func sendMessage(_ message: JCSMessage, to conversation: JCSConversation) -> AnyPublisher<[JCSConversation], Error>
}

class JCSConversationsRepository: JCSConversationsRepositoryProtocol {
    
    var fetchedResult: Result<[JCSConversation], Error> = .failure(ChatError.noData)
    init() {
        if Mode.mock == env.mode {
            fetchedResult = .success(JCSMockDataSource.conversations)
        }else {
            //from network or local db...
            fetchedResult = .failure(ChatError.noNetworker)
        }
    }
    
    func fetchConversations(for user: JCSUser) -> AnyPublisher<[JCSConversation], Error> {
        return fetchedResult.publisher.eraseToAnyPublisher()
    }
    
    func sendMessage(_ message: JCSMessage, to conversation: JCSConversation) -> AnyPublisher<[JCSConversation], Error> {
       
        if let index = JCSMockDataSource.conversations.firstIndex(where: {$0.id == conversation.id}) {
            var innerConversation = JCSMockDataSource.conversations[index]
            innerConversation.messages.append(message)
            JCSMockDataSource.conversations[index] = innerConversation
            fetchedResult = .success(JCSMockDataSource.conversations)
            return fetchedResult.publisher.eraseToAnyPublisher()
        }else {
            return Fail(outputType: [JCSConversation].self, failure: ChatError.noConversation).eraseToAnyPublisher()
        }
    }
}
