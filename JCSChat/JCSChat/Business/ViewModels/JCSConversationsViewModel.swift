//
//  JCSFriendsViewModel.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import Foundation
import Combine

class JCSConversationsViewModel: ObservableObject{
    @Published public var conversations: [JCSConversation]
    
    private var conversationsService: JCSConversationsServiceProtocol
    private var cancelSets = Set<AnyCancellable>()

    init(conversations: [JCSConversation] = [],
         conversationsService: JCSConversationsServiceProtocol = JCSConversationsService()) {
        self.conversations = conversations
        self.conversationsService = conversationsService
    }
    
    func getConversations(for user: JCSUser = JCSMockDataSource.currentUser) {
        
        self.conversationsService.fetchConversations(for: user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { [weak self] conversations in
                self?.conversations = conversations
            }
            .store(in: &cancelSets)
    }
    
  
    func sendMessage(_ message: JCSMessage, to conversation: JCSConversation) {
        self.conversationsService.sendMessage(message, to: conversation)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished: break
                }
            } receiveValue: { [weak self] conversations in
                self?.conversations = conversations
            }
            .store(in: &cancelSets)

    }
  
}
