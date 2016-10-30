//
//  RepositoriesViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/10/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    class func instantiateFromStoryboard() -> CollectionsViewController {
        let storyboard = UIStoryboard(name: "MenuViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! CollectionsViewController
    }
    
    //宣告表格視圖外觀變數
    @IBOutlet var collectionTableView:UITableView!
    
    var mainTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //移除多餘的分隔線
        collectionTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //啟動 Self Sizing Cells
        collectionTableView.estimatedRowHeight = 150.0
        collectionTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    // 修改圖片大小
    func resizeImage(image: UIImage) -> UIImage {
        let newWidth  = Int(image.size.width)
        let newHeight = 250
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CollectionsTableViewCell
        
        //設定Ｃell
        switch (indexPath as NSIndexPath).row{
            
        case 0:
            let image = resizeImage(image: UIImage(named: "cafedeadend")!)
            cell.collectionImage.image = image
            cell.collectionTitle.text = ("住宿")
            cell.collectionTitle.textColor = UIColor.white
            
        case 1:
            let image = resizeImage(image: UIImage(named: "bourkestreetbakery")!)
            cell.collectionImage.image = image
            cell.collectionTitle.text = ("餐廳")
            cell.collectionTitle.textColor = UIColor.white
            
        default:
            cell.collectionImage.image = UIImage(named: "")
            cell.collectionTitle.text = ("")
            
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            mainTitle = "住宿"
        }else{
            mainTitle = "餐廳"
        }
        self.performSegue(withIdentifier: "CollectionsViewToEventDetailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionsViewToEventDetailView" {
            let destinationController = segue.destination as! EventDetailViewController
            destinationController.mainTitle = self.mainTitle
        }
    }
}
