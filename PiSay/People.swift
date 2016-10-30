//
//  People.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/5.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import Foundation

class People {
    
    var Image = ""
    var Name = ""
    var Sex = ""
    var Birthday = ""
    var ID = ""
    var Location = ""
    var SelfIntroduction = ""
    var LocationOfWork = ""
    var EducationalBackground = ""
    
    init(Image:String, Name:String, Sex:String, Birthday:String, ID:String, Location:String, SelfIntroduction:String, LocationOfWork:String, EducationalBackground:String){
        self.Image = Image
        self.Name = Name
        self.Sex = Sex
        self.Birthday = Birthday
        self.ID = ID
        self.Location = Location
        self.SelfIntroduction = SelfIntroduction
        self.LocationOfWork = LocationOfWork
        self.EducationalBackground = EducationalBackground
    }
    
}
