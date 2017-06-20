//
//  FirebaseManager.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/23/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private lazy var commentRef: DatabaseReference = Database.database().reference().child("comments")
    
    private var commentAddedRefHandle: DatabaseHandle?
    private var commentRemovedRefHandle: DatabaseHandle?
    
    init() {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously { user, error in
            guard let _ = user else { return }
            FirebaseManager.shared.observeComments { type, id, data in
                switch type {
                case .childAdded:
                    let text = data["text"] as! String
                    let senderId = data["senderId"] as! String
                    RealmManager.shared.appendComment(id: id, text: text, senderId: senderId)
                case .childRemoved:
                    RealmManager.shared.removeComment(id: id)
                default: break
                }
            }
        }
    }
    
    func observeComments(handler: @escaping (DataEventType, String, [String: AnyObject]) -> Void) {
        commentAddedRefHandle = commentRef.observe(.childAdded, with: { snapshot in
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            handler(.childAdded, snapshot.key, data)
        })
        commentRemovedRefHandle = commentRef.observe(.childRemoved, with: { snapshot in
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            handler(.childRemoved, snapshot.key, data)
        })
    }
    
    func postComment(senderId: String, text: String) {
        commentRef.childByAutoId().setValue(["senderId": senderId, "text": text])
    }
    
}
