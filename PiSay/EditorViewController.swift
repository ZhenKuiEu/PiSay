//
//  EditorViewController.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/9.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit
import Eureka

protocol EditorViewControllerDelegate: NSObjectProtocol {
    // 協議方法
    func GetValuesOfEditorView(Values:[String: Any?])
}

//全域變數處理傳遞資料
var editorValues:[String: Any?]?

class EditorViewController: FormViewController {
    
    @IBAction func returnButton(_ sender: UIBarButtonItem) {
        let valuesDictionary = form.values()
        editorValues = valuesDictionary
        print(editorValues)
        self.performSegue(withIdentifier: "EditorViewToUserDetailView", sender: self)
    }
    
    //代理成員變數
    weak var protocolDelegate:EditorViewControllerDelegate?
    
    //調用代理函數
    func start(){
        if(editorValues != nil){
            protocolDelegate?.GetValuesOfEditorView(Values: editorValues!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blue }
        LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange  }
        CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
        DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }

        form = Section("編輯姓名")
            <<< TextRow(){ row in
                row.tag = "姓名"
                row.title = "姓 名"
                row.placeholder = "Enter text here"
            }
            
            +++ Section("編輯性別")
            <<< SegmentedRow<String>(){
                $0.tag = "性別"
                $0.title = "性 別     "
                $0.options = ["男", "女"]
            }
            
            +++ Section("編輯生日")
            <<< DateInlineRow() {
                $0.tag = "生日"
                $0.title = "生 日"
                $0.value = Date()
            }

            +++ Section("編輯地區")
            <<< TextRow(){ row in
                row.tag = "地區"
                row.title = "地 區"
                row.placeholder = "Location"
            }
        
            +++ Section("編輯自我介紹")
            <<< TextAreaRow() {
                $0.tag = "自我介紹"
                $0.placeholder = "Text Here"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 120)
            }
        
            +++ Section("編輯工作地點")
            <<< TextRow(){ row in
                row.tag = "工作地點"
                row.title = "工作地點"
                row.placeholder = "Location Of Work"
            }
        
            +++ Section("編輯學歷")
            <<< TextRow(){ row in
                row.tag = "學歷"
                row.title = "學 歷"
                row.placeholder = "Education Background"
            }
    }
}
