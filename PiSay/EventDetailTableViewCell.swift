//
//  EventDetailTableViewCell.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/17.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var userImage:UIImageView!
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var wordLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
