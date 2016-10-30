//
//  MainPageViewController.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/4.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// 標籤變數
var annotationController = [MKPointAnnotation()]
var i = 1

var Check = false

class MainPageViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    // 創建 locationManager
    let locationManager = CLLocationManager()
    
    // 協議傳值變數
    var CreateEventVC = CreateEventViewController()
    var CreateEventValues:[String: Any?]?
    
    //Zoom in
    @IBAction func magnifyButton(_ sender: UIButton) {
        var theRegion:MKCoordinateRegion  = mapView.region;
        theRegion.span.longitudeDelta *= 0.5;
        theRegion.span.latitudeDelta *= 0.5;
        mapView.setRegion(theRegion, animated: true)
    }
    
    //Zoom out
    @IBAction func shrinkButton(_ sender: UIButton) {
        var theRegion:MKCoordinateRegion  = mapView.region;
        theRegion.span.longitudeDelta *= 2.0;
        theRegion.span.latitudeDelta *= 2.0;
        mapView.setRegion(theRegion, animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 關聯代理
        CreateEventVC.paramsProtocolDelegate = self
        CreateEventVC.start()
        
        self.locationManager.delegate = self
        self.mapView.delegate = self
        
        // 關閉指南針
        //mapView.showsCompass = false
        // 設定定位精確
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 要求定位的認證
        self.locationManager.requestWhenInUseAuthorization()
        // 設定顯示自己位置
        self.mapView.showsUserLocation = true
        // 移動到目前座標
        self.locationManager.startUpdatingLocation()
        
        if (CreateEventValues != nil && Check == true){
            
            Check = false
            
            let ActivityCoordinate = [CreateEventValues?["Location"]].last
            
            //移動到活動位置
            let center = CLLocationCoordinate2D(latitude: (((ActivityCoordinate!)!)! as AnyObject).coordinate.latitude, longitude: (((ActivityCoordinate!)!)! as AnyObject).coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05))
            self.mapView.setRegion(region, animated: true)
            self.locationManager.stopUpdatingLocation()

            let annotation = MyMKAnnotation(type: (CreateEventValues?["Type"] as? String)!)
            
            annotation.title = "10-21 ~ 10-22"
            annotation.coordinate = CLLocationCoordinate2D(latitude: (((ActivityCoordinate!)!)! as AnyObject).coordinate.latitude, longitude: (((ActivityCoordinate!)!)! as AnyObject).coordinate.longitude)
        
            annotationController += [annotation]
            
            mapView.showAnnotations([annotation], animated: true)
            
            i = i + 1
             
            var j = 1
            while j < i {
              mapView.addAnnotation(annotationController[j])
              //mapView.selectAnnotation(annotationController[j], animated: true)
              j = j + 1
            }
        }
    }
    
    // 更新目前座標
    @IBAction func updatingLocation(_ sender: UIBarButtonItem) {
        // 移動到目前座標
        self.locationManager.startUpdatingLocation()
    }
    
    // 座標更新後進入
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations:[CLLocation]){
        // 設定地圖顯示範圍
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
        self.mapView.userTrackingMode = .followWithHeading
        self.locationManager.stopUpdatingLocation()
    }
    
    // 修改圖片大小
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    // 變更大頭針顯示圖案
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        
        let userLocation:MKUserLocation = mapView.userLocation
        userLocation.title = "PiSay"

       
        if let dequeueAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier){
            annotationView = dequeueAnnotationView
            annotationView?.annotation = annotation
        }
        else{
            
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            
            if annotation.isKind(of: MKUserLocation.self){
                // Left Accessory
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                imageView.image = UIImage(named:"barrafina")
                imageView.layer.cornerRadius = 30.0
                imageView.clipsToBounds = true
                av.leftCalloutAccessoryView = imageView
                
                // Detail Accessory
                let detailAccessory = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                detailAccessory.text = "  詳細介紹  "
                detailAccessory.font = UIFont(name: "Verdana", size: 30)
                av.detailCalloutAccessoryView = detailAccessory
                
            }else {
                // Detail Accessory
                var detailImage = UIImage(named:"barrafina")
                detailImage = resizeImage(image: detailImage!, newWidth: 150)
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                imageView.image = detailImage
                imageView.layer.cornerRadius = 30
                imageView.clipsToBounds = true
                av.detailCalloutAccessoryView = imageView
                
                // Left Accessory
                let leftAccessory = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                leftAccessory.text = "標題"
                leftAccessory.font = UIFont(name: "Verdana", size: 20)
                av.leftCalloutAccessoryView = leftAccessory
                
                // Right accessory view
                let rightImage = UIImage(named: "icon-arrow-right-b-128")
                let rightButton = UIButton(type: .custom)
                rightButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                rightButton.setImage(rightImage, for: .normal)
                av.rightCalloutAccessoryView = rightButton
            }
            
            annotationView = av
        }

        if annotation.isKind(of: MKUserLocation.self){
            
            if let annotationView = annotationView{
                annotationView.canShowCallout = true
                annotationView.image = UIImage(named: "morrissey-hair-50")
                
            }
        }else {
            let myAnnotation = annotation as! MyMKAnnotation
            
            if myAnnotation.type == "吃" {
                
                if let annotationView = annotationView{
                    annotationView.canShowCallout = true
                    annotationView.image = UIImage(named: "stone-roses-lemon-50")
                }
                
            }else if myAnnotation.type == "喝" {
                
                if let annotationView = annotationView{
                    annotationView.canShowCallout = true
                    annotationView.image = UIImage(named: "northen-quater-beer-50")
                }
                
            }else if myAnnotation.type == "玩" {
                
                if let annotationView = annotationView{
                    annotationView.canShowCallout = true
                    annotationView.image = UIImage(named: "road-bike-50")
                }
                
            }else if myAnnotation.type == "樂" {
                
                if let annotationView = annotationView{
                    annotationView.canShowCallout = true
                    annotationView.image = UIImage(named: "canal-boat-50")
                }
            }
        }
        
        return annotationView
    }
    
    // 活動細節連結
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.performSegue(withIdentifier: "MainPageViewToEventDetailView", sender: self)
        }
    }
}

extension MainPageViewController:CreateEventViewControllerDelegate{
    // 代理實作方法
    func GetValuesOfCreateEvent(Values:[String: Any?]){
        self.CreateEventValues = Values
        Check = true
        //print(self.CreateEventValues)
    }
}
