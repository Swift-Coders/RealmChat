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
//    dynamic var createdAt = Date()
    dynamic var from: User?
    
    convenience init(id: String, text: String, senderId: String) {
        self.init()
        self.id = id
        self.text = text
        self.from = try! Realm().object(ofType: User.self, forPrimaryKey: senderId) ?? User(id: senderId)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class User: Object {
    dynamic var id = NSUUID().uuidString
//    dynamic var username: String = ""
//    dynamic var profilePicture: String = ""
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
