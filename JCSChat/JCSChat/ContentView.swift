//
//  ContentView.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        JCSConversationView(viewModel: JCSConversationsViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
