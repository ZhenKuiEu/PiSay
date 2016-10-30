//
//  SettingDetailTableViewCell.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/5.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell{
    
    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
