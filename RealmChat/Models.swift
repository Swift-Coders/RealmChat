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

final class CommentListList: Object, ListPresentable {
    dynamic var id = 0
    let items = List<CommentList>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class CommentList: Object, CellPresentable, ListPresentable {
    dynamic var id = NSUUID().uuidString
    dynamic var text = ""
    let items = List<Comment>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Comment: Object, CellPresentable {
    dynamic var id = NSUUID().uuidString
    dynamic var text = ""
    dynamic var createdAt = Date()
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
