//
//  Message.swift
//  Flash Chat iOS13
//
//  Created by Thiện Đăng on 9/14/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation


struct Message {
    let sender : String!
    let body : String!
    init(sender : String , body : String) {
        self.sender = sender
        self.body = body
    }
}
