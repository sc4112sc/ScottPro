//
//  Home.swift
//  ScottPro
//
//  Created by ios135 on 2018/6/24.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit

class Home: UIViewController {

    var myLogin = false
    var mytimer:Timer! = nil
    var myUser = ""
    @IBOutlet weak var imgA: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    func change1(){
        
        
        switch pageControl.currentPage {
        case 0:
            imgA.image = UIImage(named: "homeBg01.jpg")
            
        case 1:
            imgA.image = UIImage(named: "555.jpg")
            
        case 2:
            imgA.image = UIImage(named: "homeBg03.jpg")
            
        default:
            imgA.image = nil
            
        }
        
    }
    
    @objc func calImage() {
        
        if pageControl.currentPage==pageControl.numberOfPages-1{
            
            pageControl.currentPage=0
            
        }else{
            
            pageControl.currentPage=pageControl.currentPage+1
            
        }
        
        self.change1()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn1.layer.cornerRadius = 30
        btn2.layer.cornerRadius = 30
        btn3.layer.cornerRadius = 30
        btn4.layer.cornerRadius = 30
        
        imgA.image = UIImage(named: "homeBg01.jpg")
        pageControl.currentPage = 0
        
        if mytimer==nil{
            
        }else{
            mytimer.invalidate()
        }
        
        mytimer=Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(calImage), userInfo: nil, repeats: true)
        
        mytimer.fire()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor.orange
        
   
    }
    
    @IBAction func calLogin(_ sender: UIButton) {
        
         let selectVC=storyboard?.instantiateViewController(withIdentifier: "viewController") as! ViewController
        if(myLogin==true){
        
            selectVC.isLogin=true
            selectVC.myUser=myUser
            show(selectVC, sender: self)
        }else{
            show(selectVC, sender: self)
            
        }
  

    }
    
    @IBAction func calNew(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "shops") as! ShopsTableViewController
        
        if (myLogin==true) {
            selectVC.shopsLogin=true
            selectVC.shopUser=myUser
            show(selectVC, sender: self)
        }else{
            
            show(selectVC, sender: self)
        }
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
