//
//  Models.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/21/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import RealmSwift

protocol ListPresentable {
    associatedtype Item: Object, CellPresentable
    var items: List<Item> { get }
}

protocol CellPresentable {
    var text: String { get set }
}

final class CommentList: Object, ListPresentable {
    let items = List<Comment>()
}

final class Comment: Object, CellPresentable {
    dynamic var id = NSUUID().uuidString
    dynamic var text = ""
    dynamic var createdAt = Date()
    dynamic var from: User?
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class User: Object {
    dynamic var id = NSUUID().uuidString
    dynamic var username: String = ""
    dynamic var profilePicture: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
