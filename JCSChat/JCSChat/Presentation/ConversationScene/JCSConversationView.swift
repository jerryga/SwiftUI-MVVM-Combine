//
//  JCSFriendsView.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import SwiftUI

struct JCSConversationView: View {
    
    @ObservedObject var viewModel: JCSConversationsViewModel

    var body: some View {
        NavigationView {
            List(viewModel.conversations) { conversation in
                
                NavigationLink(
                    destination: JCSConversationDetailView(conversation: conversation)
                ) {
                
                    if let message = conversation.lastestMessage {
                        JCSMessageView(message: message)
                    }
                    //Text(conversation.chatPartner.name)
                }
                
            }.navigationTitle("My friends")
        }.environmentObject(viewModel)
        .onAppear(perform: {
            viewModel.getConversations(for: JCSMockDataSource.currentUser)
        })
    }
}

struct JCSFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        JCSConversationView(viewModel: JCSConversationsViewModel())
    }
}
