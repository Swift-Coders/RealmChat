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
//    dynamic var from: User?
    
    convenience init(id: String, text: String) {
        self.init()
        self.id = id
        self.text = text
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//final class User: Object {
//    dynamic var id = NSUUID().uuidString
//    dynamic var username: String = ""
//    dynamic var profilePicture: String = ""
//    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}
