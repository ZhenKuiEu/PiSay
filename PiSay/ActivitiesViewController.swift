//
//  UsersViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/10/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    class func instantiateFromStoryboard() -> ActivitiesViewController {
        let storyboard = UIStoryboard(name: "MenuViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ActivitiesViewController
    }
   
    //宣告表格視圖外觀變數
    @IBOutlet var activityTableView:UITableView!
    
    var mainTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityTableView.delegate = self
        
        //移除多餘的分隔線
        activityTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //啟動 Self Sizing Cells
        activityTableView.estimatedRowHeight = 120.0
        activityTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActivitiesTableViewCell
        
        //設定Ｃell
        switch (indexPath as NSIndexPath).row{
            
        case 0:
            let image = UIImage(named: "cafeloisl")!
            cell.activityImage.image = image
            cell.activityTitle.text = ("喝茶")
            cell.activityTitle.textColor = UIColor.blue
            cell.beginLabel.text = "2016-10-18 10:00 AM"
            cell.endLabel.text = "2016-10-18 03:00 PM"
            cell.addressLabel.text = "秘密"
            
        case 1:
            let image = UIImage(named: "cafelore")!
            cell.activityImage.image = image
            cell.activityImage.layer.cornerRadius = 30.0
            cell.activityImage.clipsToBounds = true
            cell.activityTitle.text = ("喝咖啡")
            cell.activityTitle.textColor = UIColor.blue
            cell.beginLabel.text = "2016-10-17 12:00 AM"
            cell.endLabel.text = "2016-10-17 05:00 PM"
            cell.addressLabel.text = "甜蜜咖啡"
            
        default:
            cell.activityImage.image = UIImage(named: "")
            cell.activityTitle.text = ("")
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            mainTitle = "喝茶"
        }else{
            mainTitle = "喝咖啡"
        }
        self.performSegue(withIdentifier: "ActivitiesViewToEventDetailView", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivitiesViewToEventDetailView" {
            let destinationController = segue.destination as! EventDetailViewController
            destinationController.mainTitle = self.mainTitle
        }
    }
}

