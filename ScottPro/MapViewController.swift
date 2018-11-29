//
//  MapViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/8/16.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{

    var myLocationManager:CLLocationManager!
    var myMapView:MKMapView!
    
    var count = 0
    var cityTitle = ""
    
    var centerLatArray = [25.05,25.013838,24.989448,24.137687,22.997264,22.638982]
    var centerLongArray = [121.515,121.463629,121.313561,120.686474,120.211410,120.301961]
    
    var latArray1 = [25.036798,25.016798,25.006798,24.136798,22.986798,22.636798]
    var longArray1 = [121.499962,121.469962,121.319962,120.699962,120.199962,120.309962]
    
    var latArray2 = [25.063059,25.023059,25.013059,24.133059,22.983059,22.633059]
    var longArray2 = [121.533838,121.473838,121.323838,120.663838,120.183838,120.303838]
    
    var latArray3 = [25.046216,25.020216,25.006216,24.136216,22.996216,22.636216]
    var longArray3 = [121.509259,121.459259,121.309259,120.679259,120.229259,120.309259]
    
    var latArray4 = [25.032646,25.019646,25.992646,24.132646,22.985646,22.632646]
    var longArray4 = [121.521320,121.441320,121.3291320,120.681320,120.211320,120.31320]
    
    override func viewDidLoad() {
        
       
        super.viewDidLoad()

        self.navigationItem.title=cityTitle
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        print(count)
        
        myLocationManager=CLLocationManager()
        myLocationManager.delegate=self
        myLocationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        myLocationManager.desiredAccuracy=kCLLocationAccuracyBest
        
        let fullSize = UIScreen.main.bounds.size
        myMapView = MKMapView(frame: CGRect(x: 0, y: 20, width: fullSize.width, height: fullSize.height-20))
        myMapView.delegate = self
        myMapView.mapType = .standard
        myMapView.showsUserLocation = true
        myMapView.isZoomEnabled = true
        //定位移動
        myMapView.userTrackingMode = .follow
        
        
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let center:CLLocation = CLLocation(latitude: centerLatArray[count], longitude: centerLongArray[count])
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        self.view.addSubview(myMapView)
        
        
        //加入地點圖示
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: latArray1[count], longitude: longArray1[count]).coordinate
        objectAnnotation.title = "50嵐"
        objectAnnotation.subtitle = "綠茶專賣店"
        
        myMapView.addAnnotation(objectAnnotation)
        
        var objectAnnotation2 = MKPointAnnotation()
        objectAnnotation2.coordinate = CLLocation(latitude: latArray2[count], longitude: longArray2[count]).coordinate
        objectAnnotation2.title = "迷客夏"
        objectAnnotation2.subtitle = "鮮奶茶飲專賣店"
        myMapView.addAnnotation(objectAnnotation2)
        
        var objectAnnotation3 = MKPointAnnotation()
        objectAnnotation3.coordinate = CLLocation(latitude: latArray3[count], longitude: longArray3[count]).coordinate
        objectAnnotation3.title = "茶湯會"
        objectAnnotation3.subtitle = "茶飲專賣店"
        myMapView.addAnnotation(objectAnnotation3)
        
        var objectAnnotation4 = MKPointAnnotation()
        objectAnnotation4.coordinate = CLLocation(latitude: latArray4[count], longitude: longArray4[count]).coordinate
        objectAnnotation4.title = "大苑子"
        objectAnnotation4.subtitle = "果汁茶飲專賣店"
        myMapView.addAnnotation(objectAnnotation4)
        
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            myLocationManager.requestWhenInUseAuthorization()
            myLocationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .denied {
            let alertController = UIAlertController(title: "定位權限已關閉", message: "請至 設定>隱私權>定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            myLocationManager.startUpdatingLocation()
        }
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //印出目前所在位置座標
        let currentLocation:CLLocation = locations[0] as CLLocation
        print("經度\(currentLocation.coordinate.latitude)")
        print("緯度\(currentLocation.coordinate.longitude)")
        
//        let center=CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
//        let region=MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        myMapView.setRegion(region, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        myLocationManager.stopUpdatingLocation()
    }
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myMapView"
        
        //定位外觀
        guard annotation is MKPointAnnotation else { return nil }



        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
//        var markerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//
//
//        markerView.markerTintColor = UIColor.blue
//        markerView.glyphTintColor = UIColor.yellow
//        markerView.glyphText="yyyyy"
        
       
            if annotation.title! == "50嵐" {
                annotationView.pinTintColor = UIColor.yellow
                annotationView.leftCalloutAccessoryView = UIImageView.init(image: #imageLiteral(resourceName: "star"))
                //annotationView.image = UIImage(named: "222.jpg")


            }else if annotation.title! == "迷客夏" {
                annotationView.pinTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                annotationView.leftCalloutAccessoryView = UIImageView.init(image: #imageLiteral(resourceName: "star03"))

            }else if annotation.title! == "茶湯會" {
                annotationView.pinTintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
                annotationView.leftCalloutAccessoryView = UIImageView.init(image: #imageLiteral(resourceName: "star04"))
                
            }else if annotation.title! == "大苑子" {
                annotationView.pinTintColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                annotationView.leftCalloutAccessoryView = UIImageView.init(image: #imageLiteral(resourceName: "star02"))
                
        }



        
        
       
        annotationView.canShowCallout = true
        

        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        userLocation.title = "我在這呦！"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
