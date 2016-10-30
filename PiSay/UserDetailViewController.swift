//
//  SettingDetailViewController.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/5.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditorViewControllerDelegate {
    
    // 假人設置
    var people:[People] = [People(Image:"barrafina", Name:"PiSay", Sex:"男", Birthday:"2016年9月11日", ID:"0123456", Location:"新竹", SelfIntroduction:"您好，我叫PiSay，個性開朗活潑，喜愛運動，座右銘為今日事今日畢，很高興認識你．", LocationOfWork:"新竹", EducationalBackground:"夾娃娃大學")]
    
    @IBOutlet var userTitleView:UILabel!
    @IBOutlet var userImageView:UIImageView!
    
    // 表格視圖外觀變數
    @IBOutlet var userTableView:UITableView!
    
    // 協議傳值變數
    var editorValues:[String: Any?]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將返回按鈕標題清空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target: nil, action: nil)
        
        // 個人頁標題設定
        userTitleView.text = "個 人 檔 案"
        
        // 個人頁大頭照設定
        userImageView.image = UIImage(named: people[0].Image)
        userImageView.layer.cornerRadius = 60.0
        userImageView.clipsToBounds = true
        
        // 個人頁表格視圖外觀設定
        //userTableView.backgroundColor = UIColor(red: 0.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        // 移除多餘的分隔線
        userTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // 啟動 Self Sizing Cells
        userTableView.estimatedRowHeight = 50.0
        userTableView.rowHeight = UITableViewAutomaticDimension
        
        // 藏起返回按鈕
        self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //關聯代理
        let EditorVC = EditorViewController()
        EditorVC.protocolDelegate = self
        EditorVC.start()
        print("123~~~")
        print(editorValues)
        if let Name = editorValues?["姓名"]!{
            people[0].Name = Name as! String
        }
        if let Sex = editorValues?["性別"]!{
            people[0].Sex = Sex as! String
        }
        if let Birthday = editorValues?["生日"]!{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.long
            let convertedDate = dateFormatter.string(from: Birthday as! Date)
            people[0].Birthday = convertedDate
        }
        if let Location = editorValues?["地區"]!{
            people[0].Location = Location as! String
        }
        if let SelfIntroduction = editorValues?["自我介紹"]!{
            people[0].SelfIntroduction = SelfIntroduction as! String
        }
        if let LocationOfWork = editorValues?["工作地點"]!{
            people[0].LocationOfWork = LocationOfWork as! String
        }
        if let EducationalBackground = editorValues?["學歷"]!{
            people[0].EducationalBackground = EducationalBackground as! String
        }
    }

    // 個人頁列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    // 個人頁資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserDetailTableViewCell
        
        //設定Ｃell
        switch (indexPath as NSIndexPath).row{
            
        case 0:
            cell.fieldLabel.text = "姓 名"
            cell.valueLabel.text = people[0].Name
            
        case 1:
            cell.fieldLabel.text = "性 別"
            cell.valueLabel.text = people[0].Sex
            
        case 2:
            cell.fieldLabel.text = "生 日"
            cell.valueLabel.text = people[0].Birthday
            
        case 3:
            cell.fieldLabel.text = "ID"
            cell.valueLabel.text = people[0].ID
            
        case 4:
            cell.fieldLabel.text = "地 區"
            cell.valueLabel.text = people[0].Location
            
        case 5:
            cell.fieldLabel.text = "自我介紹"
            cell.valueLabel.text = people[0].SelfIntroduction
            
        case 6:
            cell.fieldLabel.text = "工作地點"
            cell.valueLabel.text = people[0].LocationOfWork
            
        case 7:
            cell.fieldLabel.text = "學 歷"
            cell.valueLabel.text = people[0].EducationalBackground
            
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
            
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // 選取內建照片按鈕
    @IBAction func PhoteLibrary(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImageView.image = image
            userImageView.contentMode = UIViewContentMode.scaleAspectFill
            userImageView.layer.cornerRadius = 60.0
            userImageView.clipsToBounds = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 使用照相機按鈕
    @IBAction func Camera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",style:.default,handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }

    // 實作協議函數（傳值）
    func GetValuesOfEditorView(Values:[String: Any?]){
        self.editorValues = Values
        //print(Values)
    }
}


