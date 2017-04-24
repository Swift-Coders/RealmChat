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
    
    private var notificationToken: NotificationToken?
    
    func postComment(text: String) {
        try! comments.realm?.write {
            let comment = Comment(text: text)
            comments.append(comment)
        }
    }
    
    func observeComments(handler: @escaping (_ deletions: [Int], _ insertions: [Int], _ modifications: [Int]) -> Void) {
        notificationToken = comments.addNotificationBlock { changes in
            switch changes {
            case .initial(let value):
                break
            case .update(let value, let deletions, let insertions, let modifications):
                handler(deletions, insertions, modifications)
            case .error(let error):
                break
            }
        }
    }
    
}
