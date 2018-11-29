//
//  ViewController.swift
//  ScottPro
//
//  Created by ios135 on 2018/6/3.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITextFieldDelegate {

    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    var myUser=""
    var isLogin = false
    @IBOutlet weak var loginText: UILabel!
    @IBOutlet weak var rORg: UIView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var inBtn: UIButton!
    @IBOutlet weak var outBtn: UIButton!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userName.delegate=self
        password.delegate=self
        //userName.becomeFirstResponder()
        
        context=appDel.persistentContainer.viewContext
        
        inBtn.layer.cornerRadius = 12
        outBtn.layer.cornerRadius = 12
        
        btn1.layer.cornerRadius = 20
        btn2.layer.cornerRadius = 20
        btn3.layer.cornerRadius = 20
        btn4.layer.cornerRadius = 20
        
        rORg.layer.cornerRadius = 10
        
        
        
        if isLogin == true{
            rORg.backgroundColor = UIColor.green
            loginText.text = "已登入"
            btn3.isEnabled=true
            btn3.alpha=1
            
            inBtn.isEnabled=false
        }else{
            rORg.backgroundColor = UIColor.red
            loginText.text = "尚未登入"
            btn3.isEnabled=false
            btn3.alpha=0.5
            
            inBtn.isEnabled=true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func serviceClick(_ sender: UIButton) {
    }
    @IBAction func loginClick(_ sender: UIButton) {
        if userName.text=="" || password.text==""{
            message(myTitle: "輸入錯誤", myMessage: "帳號或密碼不可為空白")
        }else{
            let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
            let allusers=try! context.fetch(fetchRequest)
            var num=0
            for user in allusers{
                if user.username==userName.text! && user.password==password.text!{
                    
                    myUser=userName.text!
                    
                    inBtn.isEnabled=false
                    
                    
                    rORg.backgroundColor = UIColor.green
                    loginText.text = "已登入"
                    isLogin = true
                    btn3.isEnabled=true
                    btn3.alpha=1.0
                    message(myTitle: "登入成功", myMessage: "")
                    num=1
                    break
                }
                
            }
            if num == 0{
                message(myTitle:"登入失敗", myMessage: "")
            }
    

        }
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
    }
    


    func message(myTitle:String,myMessage:String) {
        let alertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==userName{
            password.becomeFirstResponder()
        }else if textField==password{
            password.resignFirstResponder()
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func goHome(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "home") as! Home
        
        if (isLogin==true) {
            selectVC.myLogin=true
            selectVC.myUser=myUser
            show(selectVC, sender: self)
        }else{
            
            show(selectVC, sender: self)
        }
        
    }
    
    @IBAction func calLogout(_ sender: Any) {
        isLogin = false
        rORg.backgroundColor = UIColor.red
        loginText.text = "尚未登入"
        btn3.isEnabled=false
        btn3.alpha=0.5
        userName.text=""
        password.text=""
        
        inBtn.isEnabled=true
        
    }
    
    @IBAction func calCheep(_ sender: Any) {
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "star") as! StatViewController
        selectVC.myUser=myUser
        show(selectVC, sender: self)
    }
    
    
}

