//
//  ViewController.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/21/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import SlackTextViewController
import RealmSwift
import FirebaseAuth

class ViewController: SLKTextViewController {
    
    override var tableView: UITableView {
        return super.tableView!
    }
    
    var comments: List<Comment> {
        return RealmManager.shared.comments
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Comments"
        
        isInverted = false
        shakeToClearEnabled = true
        shouldScrollToBottomAfterKeyboardShows = true
        
        tableView.estimatedRowHeight = 44
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        
        textInputbar.autoHideRightButton = false
        textInputbar.backgroundColor = .white
        textInputbar.setBackgroundImage(UIImage(color: .white), forToolbarPosition: .any, barMetrics: .default)
        
        textView.backgroundColor = .white
        textView.layer.borderWidth = 0
        textView.placeholder = "Type a message"
        
        RealmManager.shared.observeComments { [unowned tableView] deletions, insertions, modifications in
            tableView.beginUpdates()
            tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
            tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .none)
            tableView.endUpdates()
            
            if let row = insertions.last {
                tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
}

// MARK: - SlackTextViewController
extension ViewController {
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
    override func didPressRightButton(_ sender: Any?) {
        textView.refreshFirstResponder()
        guard let text = textView.text, let senderId = Auth.auth().currentUser?.uid else { return }
        FirebaseManager.shared.postComment(senderId: senderId, text: text)
        super.didPressRightButton(sender)
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = comment.text
        cell.detailTextLabel?.text = comment.senderId
        cell.selectionStyle = .none
        cell.transform = tableView.transform
        return cell
    }
    
}
