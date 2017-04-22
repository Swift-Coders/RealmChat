//
//  Cell.swift
//  RealmChat
//
//  Created by Lasha Efremidze on 4/21/17.
//  Copyright © 2017 efremidze. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet fileprivate weak var _imageView: UIImageView! {
        didSet {
            _imageView.contentMode = .scaleAspectFill
            _imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
            _imageView.layer.borderWidth = 0.5
            _imageView.layer.cornerRadius = _imageView.frame.width / 2
            _imageView.layer.masksToBounds = true
        }
    }
    @IBOutlet fileprivate weak var _textLabel: UILabel! {
        didSet {
            _textLabel.font = .systemFont(ofSize: 12)
            _textLabel.textColor = UIColor(red: 120, green: 125, blue: 143)
        }
    }
    @IBOutlet fileprivate weak var _detailTextLabel: UILabel! {
        didSet {
            _detailTextLabel.font = .systemFont(ofSize: 12)
            _detailTextLabel.textColor = UIColor(red: 31, green: 39, blue: 65)
            _detailTextLabel.textAlignment = .left
            _detailTextLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var rightLabel: UILabel! {
        didSet {
            rightLabel.font = .boldSystemFont(ofSize: 8)
            rightLabel.textColor = UIColor(red: 1, green: 126, blue: 138)
            rightLabel.textAlignment = .right
        }
    }
    
    override var imageView: UIImageView? {
        return _imageView
    }
    
    override var textLabel: UILabel? {
        return _textLabel
    }
    
    override var detailTextLabel: UILabel? {
        return _detailTextLabel
    }
    
}
