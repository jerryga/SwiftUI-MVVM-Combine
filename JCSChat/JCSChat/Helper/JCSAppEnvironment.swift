//
//  JCSAppMode.swift
//  JCSChat
//
//  Created by YangCheng on 2021/12/17.
//

import Foundation

enum Mode {
    case production
    case mock
}

class AppEnvironment: ObservableObject{

    var mode: Mode
    init(mode: Mode = Mode.production) {
        self.mode = mode
    }
}


