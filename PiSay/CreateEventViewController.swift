//
//  CreateEventViewController.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/9.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

protocol CreateEventViewControllerDelegate{
    // 協議方法
    func GetValuesOfCreateEvent(Values:[String: Any?])
}

//全域變數處理傳遞資料
var myValues:[String: Any?]?

class CreateEventViewController: FormViewController {
    
    @IBAction func returnButton(_ sender: UIBarButtonItem) {
        
        let valuesDictionary = form.values()
       
        if (valuesDictionary["Title"])! == nil || (valuesDictionary["Type"])! == nil || (valuesDictionary["Address"])! == nil || (valuesDictionary["Location"])! == nil {
            showMessage("有欄位尚未輸入", type: .error, options: [.animation(.fade),.textPadding(60.0),.hideOnTap(true),.height(44.0),.textNumberOfLines(1)])
        } else{
            myValues = valuesDictionary
            self.performSegue(withIdentifier: "CreateEventViewToMainPageView", sender: self)
        }
        
    }
    
    //代理成員變數
    var paramsProtocolDelegate: CreateEventViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //將返回按鈕標題清空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        
        
        URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blue }
        LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange  }
        CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
        DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }
        

        form = Section("活動名稱")
            <<< TextRow(){ row in
                row.tag = "Title"
                row.title = "標 題"
                row.placeholder = "Title"
            }
            
            +++ Section("活動類型")
            <<< SegmentedRow<String>(){
                $0.tag = "Type"
                $0.title = "類 型   "
                $0.options = ["吃", "喝", "玩", "樂"]
                $0.value = "吃"
            }
        
            +++ Section("活動時間")
            <<< DateTimeInlineRow(){
                $0.tag = "BeginTime"
                $0.title = "開 始"
                $0.value = NSDate() as Date
            }
            
            <<< DateTimeInlineRow(){
                $0.tag = "EndTime"
                $0.title = "結 束"
                $0.value = NSDate() as Date
            }
            
            +++ Section("活動地點")
            <<< TextRow(){ row in
                row.tag = "Address"
                row.title = "地 址"
                row.placeholder = "Location"
            }
        
            <<< LocationRow(){
                $0.tag = "Location"
                $0.title = "地圖位置"
                //$0.value = CLLocation(latitude: -34.91, longitude: -56.1646)
            }
            
            +++ Section("活動介紹")
            <<< TextAreaRow() {
                $0.tag = "Explain"
                $0.placeholder = "說明(Text Here)"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 120)
            }

        
    }
    
    // 變更 prepareSegue 方法
    var slideRightTransition = SlideRightTransitionAnimator()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let toViewController = segue.destination
        
        toViewController.transitioningDelegate = self.slideRightTransition
    
    }
    
    //調用代理函數
    func start(){
        if(myValues != nil){
            self.paramsProtocolDelegate?.GetValuesOfCreateEvent(Values:myValues!)
        }
    }
}

