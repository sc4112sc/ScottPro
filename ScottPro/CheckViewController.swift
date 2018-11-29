//
//  CheckViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/8/2.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class CheckViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    //
    var myUser=""
    
    var myFinalText=""
    
    var myAllMoney=0
    static var myStar=0
    var myShopName=""
    var nowTime=""
    var dicel=arc4random_uniform(100)+1


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let formatter=DateFormatter()
        formatter.locale=Locale(identifier: "zh_TW")
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        nowTime=formatter.string(from: Date())
        cell.textLabel?.text="我的飲料單-"+myShopName+"   共"+String(myAllMoney)+"元"
        cell.detailTextLabel?.text=nowTime
        //cell.imageView?.image=UIImage(named: "x01")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let secVC=storyboard?.instantiateViewController(withIdentifier: "checkDetail") as! CheckDetailViewController
        secVC.myItems=myFinalText
        secVC.myToF=true
        secVC.myMany=nowTime+String(dicel)
        show(secVC, sender: self)
    }
    

    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
       
    }

    var checkLogin = false
    var isLogin = false
    @IBAction func calDone(_ sender: Any) {
        if isLogin == true{
            
            let formatter=DateFormatter()
            formatter.locale=Locale(identifier: "zh_TW")
            formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
            nowTime=formatter.string(from: Date())
            
            let allUser0 = try! context.fetch(UserData.fetchRequest())
            
            for user0 in allUser0 as! [UserData]
            {
                if user0.username==myUser{
                    
                    
                    CheckViewController.myStar=Int(user0.star)
                    break
                }
                
            }
            
            
            
            let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
            let predicate=NSPredicate(format: "username = '\(myUser)'")
            fetchRequest.predicate=predicate
            let allusers = try! context.fetch(fetchRequest)
            
            
            if myAllMoney>=200{
            CheckViewController.myStar=CheckViewController.myStar+1
                if CheckViewController.myStar>=5{
                    CheckViewController.myStar=5
                }
                
                allusers[0].star=Int32(CheckViewController.myStar)
                
                appDel.saveContext()
            }
            
            //CoreData取得表單列表
            let item = NSEntityDescription.insertNewObject(forEntityName: "Items", into: context) as! Items
            item.drink=myFinalText
            item.money=String(myAllMoney)
            item.shop=myShopName
            item.time=nowTime
            item.many=nowTime+String(dicel)
            appDel.saveContext()
            
            let alertController = UIAlertController(title: "訂單完成", message: "店家將跟您連絡", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "回首頁", style: .cancel){
                (alert: UIAlertAction!) -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! Home
                
                
                if(self.checkLogin==true){
                    vc.myLogin=true
                    vc.myUser=self.myUser
                    self.show(vc, sender: self)
                }else{
                    self.show(vc, sender: self)
                }
                
            }
            
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
            

        }else{
            
            let alertController = UIAlertController(title: "訂單失敗", message: "請先登入", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "重新選擇", style: .cancel){
                (alert: UIAlertAction!) -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! Home
                
                if(self.checkLogin==true){
                    vc.myLogin=true
                    self.show(vc, sender: self)
                }else{
                    self.show(vc, sender: self)
                }
            }
            
            let ok2 = UIAlertAction(title: "登入", style: .destructive){
                (alert: UIAlertAction!) -> Void in
                self.login()
            }
            
            alertController.addAction(ok)
            alertController.addAction(ok2)
            self.present(alertController, animated: true, completion: nil)
            
        }

        
        

    }

    func login() {
        
        
        let alertController2 = UIAlertController(title: "登入", message: "請輸入帳號與密碼", preferredStyle: .alert)
        
        alertController2.addTextField { (textField: UITextField!) in
            textField.placeholder = "帳號"
        }

        alertController2.addTextField { (textField: UITextField!) in
            textField.placeholder = "密碼"

            textField.isSecureTextEntry = true
        }
        
        let ookk = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    
        
        let ookk2 = UIAlertAction(title: "登入", style: .destructive){
            (alert: UIAlertAction!) -> Void in
            
            //self.isLogin = true
            let acc = (alertController2.textFields?.first)! as UITextField
            let password = (alertController2.textFields?.last)! as UITextField
            print(acc.text!)
            print(password.text!)
            
            if acc.text=="" || password.text==""{
                self.message(myTitle: "輸入錯誤", myMessage: "帳號或密碼不可為空白")
            }else{
                let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
                let allusers=try! self.context.fetch(fetchRequest)
                var num=0
                for user in allusers{
                    if user.username==acc.text! && user.password==password.text!{

                        self.myUser=acc.text!
                        
                        self.checkLogin = true
                        self.isLogin = true
                        self.message(myTitle: "登入成功", myMessage: "")
                        num=1
                        break
                    }

                }
                if num == 0{
                    self.message(myTitle:"登入失敗", myMessage: "")
                }


            }
            
        }
        
        alertController2.addAction(ookk)
        alertController2.addAction(ookk2)
        self.present(alertController2, animated: true, completion: nil)
        
        
        
    }
    
    func message(myTitle:String,myMessage:String) {
        let alertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate=self
        myTableView.dataSource=self

        grayBg.isHidden=false
        busy.startAnimating()
        counter=0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        //core data
        context=appDel.persistentContainer.viewContext
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var grayBg: UIView!
    @IBOutlet weak var busy: UIActivityIndicatorView!
    var counter=0
    var timer = Timer()
    
    @objc func timerAction() {
        counter=counter+1
        if counter==5{
           
           busy.stopAnimating()
           grayBg.isHidden=true
           counter=0
           timer.invalidate()
            
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
