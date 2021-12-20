//
//  JCSMessageView.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import SwiftUI

struct JCSMessageView : View {
   var message: JCSMessage
    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if message.isCurrentUser {
                Spacer()
                Text(message.content)
                    .padding(10)
                    .background(.gray)
                
                Text(message.user.name)
                    .padding(10)
                    .background(.gray)
            } else {
                Text(message.user.name)
                    .padding(10)
                    .background(.gray)
                Text(message.content)
                    .padding(10)
                    .background(.gray)
                Spacer()
            }
        }.padding()
    }
}


struct JCSMessageView_Previews: PreviewProvider {
    static var previews: some View {
        JCSMessageView(message: JCSMessage.init(content: "How are you?", user: JCSMockDataSource.currentUser))

    }
}
