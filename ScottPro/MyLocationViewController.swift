//
//  MyLocationViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/9/6.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MyLocationViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    var myLocationManager:CLLocationManager!
    var myMapView:MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        let center:CLLocation = CLLocation(latitude: 25.05, longitude: 121.515)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        self.view.addSubview(myMapView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        let center=CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region=MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        myMapView.setRegion(region, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        myLocationManager.stopUpdatingLocation()
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
