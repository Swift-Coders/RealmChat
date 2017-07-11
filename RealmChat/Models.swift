//
//  Models.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/21/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import RealmSwift

final class CommentList: Object {
    let items = List<Comment>()
}

final class Comment: Object {
    dynamic var id = NSUUID().uuidString
    dynamic var text = ""
    dynamic var senderId = ""
    dynamic var state: State = .pending
    @objc enum State: Int {
        case pending, success, failure
    }
    
    // "https://api.adorable.io/avatars/100/\(id).png"
    
    convenience init(id: String, text: String, senderId: String) {
        self.init()
        self.id = id
        self.text = text
        self.senderId = senderId
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
