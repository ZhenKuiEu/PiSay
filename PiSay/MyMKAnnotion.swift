//
//  MyMKAnnotion.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/11.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit
import MapKit

class MyMKAnnotation: MKPointAnnotation {

    var type: String?
    
    init(type: String) {
        self.type = type
    }
}
