//
//  EventDetailViewController.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/14.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var mainTitle: String?
    
    var gossip:[Gossip] = [Gossip(Time:"10-20", Image:"barrafina", Name:"PiSay", Word:"創建了這個活動")]
    
    //輸入框
    @IBOutlet var myTextField: UITextField!
    private var currentTextField: UITextField?
    private var isKeyboardShown = false
    
    var keyboardAnimationDetail:[String: AnyObject] = [:]

    @IBAction func sendButton(_ sender: UIButton) {
        if myTextField.text! != "" {
            // 取得日期
            let date = NSDate()
            let formatter = DateFormatter();
            formatter.dateFormat = "HH:mm";
            
            let dateHM = formatter.string(from: date as Date);
            let newGossip = Gossip(Time:dateHM, Image:"barrafina", Name:"PiSay", Word:myTextField.text!)
            gossip += [newGossip]
            
            self.eventTableView.reloadData()
            // 還原
            myTextField.text = ""
            // 收起鍵盤
            let duration = TimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
            })
            self.myTextField.resignFirstResponder()
            
            // 將 eventTableView 滾到最底
            let numberOfSections = eventTableView.numberOfSections
            let numberOfRows = eventTableView.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                let i = [0, numberOfRows - 1]
                let indexPath = NSIndexPath(indexes: i, length: i.count)
                
                eventTableView.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
            }
        }
    }
    
    // 宣告表格視圖外觀變數
    @IBOutlet var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = mainTitle
        
        // 輸入框設定
        NotificationCenter.default.addObserver(self,selector: #selector(EventDetailViewController.keyboardWillShow(_:)),name: NSNotification.Name.UIKeyboardWillShow,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(EventDetailViewController.keyboardWillHide(_:)),name: NSNotification.Name.UIKeyboardWillHide,object: nil)
        
        // 尚未輸入時的預設顯示提示文字
        myTextField.placeholder = "請輸入文字"
        
        // 輸入框的樣式 這邊選擇圓角樣式
        myTextField.borderStyle = .roundedRect
        
        // 輸入框右邊顯示清除按鈕時機 這邊選擇當編輯時顯示
        myTextField.clearButtonMode = .whileEditing
        
        // 輸入框適用的鍵盤 這邊選擇 適用輸入 Email 的鍵盤(會有 @ 跟 . 可供輸入)
        myTextField.keyboardType = .emailAddress
        
        // 鍵盤上的 return 鍵樣式 這邊選擇 Done
        myTextField.returnKeyType = .done
        
        // 輸入文字的顏色
        myTextField.textColor = UIColor.white
        
        // UITextField 的背景顏色
        myTextField.backgroundColor = UIColor.lightGray
        
        myTextField.delegate = self
        
        //表格視圖外觀設定
        //eventTableView.backgroundColor = UIColor(red: 0.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        //移除多餘的分隔線
        eventTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //啟動 Self Sizing Cells
        eventTableView.estimatedRowHeight = 75.0
        eventTableView.rowHeight = UITableViewAutomaticDimension

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(_ note: Notification) {
        if isKeyboardShown {
            return
        }
        if (currentTextField != myTextField) {
            return
        }
        let keyboardAnimationDetail = (note as NSNotification).userInfo as! [String: AnyObject]
        
        self.keyboardAnimationDetail = keyboardAnimationDetail
        
        let duration = TimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        let keyboardFrameValue = keyboardAnimationDetail[UIKeyboardFrameBeginUserInfoKey]! as! NSValue
        let keyboardFrame = keyboardFrameValue.cgRectValue
        print(keyboardFrame.size.height)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -258 + 50)
        })
        
        isKeyboardShown = true
    }
    
    func keyboardWillHide(_ note: Notification) {
        let keyboardAnimationDetail = (note as NSNotification).userInfo as! [String: AnyObject]
        let duration = TimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.view.frame.origin.y)
        })
        isKeyboardShown = false
    }

    // 活動頁列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gossip.count
    }
    
    // 活動頁資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventDetailTableViewCell
        
        // 設定Ｃell
        cell.timeLabel.text = gossip[indexPath.row].Time
        
        cell.userImage.image = UIImage(named: gossip[indexPath.row].Image)
        cell.userImage.layer.cornerRadius = 25.0
        cell.userImage.clipsToBounds = true
        
        cell.nameLabel.text = gossip[indexPath.row].Name
        
        cell.wordLabel.text = gossip[indexPath.row].Word
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

}
