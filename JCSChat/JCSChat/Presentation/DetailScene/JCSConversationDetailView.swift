//
//  JCSConversationView.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import SwiftUI

struct JCSConversationDetailView: View {
    
    var conversation: JCSConversation
    @State var messageContent: String = ""
    @FocusState private var showKeyboard: Bool
    
    @EnvironmentObject var viewModel: JCSConversationsViewModel
    
    var body: some View {
        VStack {
            List(conversation.messages) { message in
                JCSMessageView(message: message)
            }
            HStack {
                TextField("Message...", text: $messageContent)
                    .focused($showKeyboard)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                Button("Send") {
                    showKeyboard = false
                    let message = JCSMessage.init(content: messageContent, user: JCSMockDataSource.currentUser)
                    self.viewModel.sendMessage(message, to: conversation)
                    
                    Task {
                        await waitingReply(messageContent)
                        messageContent = ""
                    }

                }}
        }
    }
    
    func sendMessage() {
        showKeyboard = false
    }
    
    private func waitingReply(_ mockReply: String) async {
        await Task.sleep(UInt64(1 * Double(NSEC_PER_SEC)))
        
        let mockRepliedMessage = JCSMessage.init(content: mockReply, user: conversation.chatPartner)
        self.viewModel.sendMessage(mockRepliedMessage, to: conversation)
    }
    
}

struct JCSConversationView_Previews: PreviewProvider {
    static var previews: some View {
        JCSConversationDetailView(conversation: JCSMockDataSource.conversations.first!)
    }
}
