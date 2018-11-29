//
//  CityViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/9/4.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        var bArrar = [btn2,btn3,btn4,btn5,btn6,btn7]
        for i in bArrar{
            
            i?.layer.cornerRadius = 40
            i?.clipsToBounds=true
        }
        
        btn1.layer.cornerRadius=20
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cal1(_ sender: Any) {
         let selectVC=storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        selectVC.cityTitle="台北市地圖"
        selectVC.count = 0
        show(selectVC, sender: self)
    }
    
    @IBAction func cal2(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        selectVC.cityTitle="新北市地圖"
        selectVC.count = 1
        show(selectVC, sender: self)
    }
    
    @IBAction func cal3(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        selectVC.cityTitle="桃園市地圖"
        selectVC.count = 2
        show(selectVC, sender: self)
    }
    
    @IBAction func cal4(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
       
        selectVC.cityTitle="台中市地圖"
        selectVC.count = 3
        show(selectVC, sender: self)
    }
    
    @IBAction func cal5(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
       
        selectVC.cityTitle="台南市地圖"
        selectVC.count = 4
        show(selectVC, sender: self)
    }
    
    @IBAction func cal6(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        selectVC.cityTitle="高雄市地圖"
        selectVC.count = 5
        show(selectVC, sender: self)
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
