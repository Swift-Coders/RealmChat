//
//  FirebaseManager.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/23/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private lazy var commentRef: FIRDatabaseReference = FIRDatabase.database().reference().child("comments")
    
    private var commentAddedRefHandle: FIRDatabaseHandle?
    private var commentRemovedRefHandle: FIRDatabaseHandle?
    
    func observeComments(handler: @escaping (FIRDataEventType, String, [String: AnyObject]) -> Void) {
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
