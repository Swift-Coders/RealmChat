//
//  ViewController.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/21/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit
import SlackTextViewController
import RealmSwift

class ViewController: SLKTextViewController {
    
    override var tableView: UITableView {
        return super.tableView!
    }
    
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Comments"
        
        isInverted = false
        shakeToClearEnabled = true
        shouldScrollToBottomAfterKeyboardShows = true
        
        tableView.estimatedRowHeight = 44
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
//        tableView.registerNib(Cell.self)
        tableView.separatorColor = UIColor(red: 224, green: 224, blue: 229)
        
        textInputbar.autoHideRightButton = false
        textInputbar.backgroundColor = .white
        textInputbar.setBackgroundImage(UIImage(color: .white), forToolbarPosition: .any, barMetrics: .default)
        
        textView.backgroundColor = .white
        textView.layer.borderWidth = 0
        textView.placeholder = "Type a message"
        textView.placeholderColor = UIColor(red: 193, green: 193, blue: 197)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - SlackTextViewController
extension ViewController {
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        return .plain
    }
    
    override func didPressRightButton(_ sender: Any?) {
        self.textView.refreshFirstResponder()
        
        let row = comments.count
        items.insert(Item(), at: row)
        let indexPath = IndexPath(row: row, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        cell = tableView.cellForRow(at: indexPath) as! TableViewCell<Item>

        
//        guard let text = viewController.textView.text else { return }
//        let comment = RLMComment()
//        comment.text = text
//        comment.user = RLMUser.myUser()
//        
//        let indexPath = IndexPath(row: self.comments.count, section: 0)
//        
//        self.comments.append(comment)
//        
//        viewController.tableView.beginUpdates()
//        viewController.tableView.insertRows(at: [indexPath], with: .bottom)
//        viewController.tableView.endUpdates()
//        
//        viewController.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//        
//        SHTNetworkManager.postComment(article: self.article, user: RLMUser.myUser(), text: text) { json, error in }
        
        
        
//        try! item.realm?.write {
//            item.completed = completed
//        }
        
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
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
//        cell.imageView?.af_setImage(withURL: comment.user?.imageUrlString.toURL())
//        cell.textLabel?.text = comment.user?.username
//        cell.detailTextLabel?.text = comment.text
//        cell.rightLabel.text = {
//            let formatter = DateInRegionFormatter()
//            formatter.maxComponentCount = 1
//            formatter.unitStyle = .abbreviated
//            return try! formatter.timeComponents(from: DateInRegion(absoluteDate: comment.date), to: DateInRegion())
//        }()
        
        //////
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = comment.text
        //////
        
        cell.selectionStyle = .none
        cell.transform = tableView.transform
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets()
    }
    
}
