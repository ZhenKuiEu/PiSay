//
//  ActivitiesTableViewCell.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/15.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    
    @IBOutlet var activityImage:UIImageView!
    
    @IBOutlet var activityTitle:UILabel!
    @IBOutlet var beginLabel:UILabel!
    @IBOutlet var endLabel:UILabel!
    @IBOutlet var addressLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
