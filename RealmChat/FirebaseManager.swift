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
    private var commentRefHandle: FIRDatabaseHandle?
    
    func postComment(senderId: String, text: String) {
        commentRef.childByAutoId().setValue(["senderId": senderId, "text": text])
    }
    
    func observeComments(handler: @escaping ([String: AnyObject]) -> Void) {
        commentRefHandle = commentRef.observe(.childAdded, with: { snapshot in
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            print(data)
            handler(data)
        })
    }
    
}
