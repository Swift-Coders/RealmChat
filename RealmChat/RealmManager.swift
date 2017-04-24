//
//  RealmManager.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/23/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private lazy var list: CommentList = {
        let realm = try! Realm()
        return realm.objects(CommentList.self).first ?? {
            let list = CommentList()
            try! realm.write {
                realm.add(list)
            }
            return list
        }()
    }()
    
    var comments: List<Comment> {
        return list.items
    }
    
    private var token: NotificationToken?
    
    func postComment(text: String) {
        try! comments.realm?.write {
            let comment = Comment(id: id, text: text)
            comments.append(comment)
        }
    }
    
    func observeComments(handler: @escaping (_ deletions: [Int], _ insertions: [Int], _ modifications: [Int]) -> Void) {
        token = comments.addNotificationBlock { changes in
            if case let .update(_, deletions, insertions, modifications) = changes {
                handler(deletions, insertions, modifications)
            }
        }
    }
    
}
