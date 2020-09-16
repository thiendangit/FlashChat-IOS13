//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Thiện Đăng on 9/15/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftAvatar: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rightAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = containerView.frame.size.height / 4
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
