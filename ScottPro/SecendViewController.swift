//
//  SecendViewController.swift
//  ScottPro
//
//  Created by ios135 on 2018/6/10.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class SecendViewController: UIViewController {

    @IBOutlet weak var secUserName: UITextField!
    @IBOutlet weak var secPassword: UITextField!
    @IBOutlet weak var secEmail: UITextField!
    @IBOutlet weak var userMobile: UITextField!
    @IBOutlet weak var secContent: UITextView!
    var un=""
    var pw=""
    var em=""
    var mb=""
    
    var appDel=UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext!
    
    var userdefault=UserDefaults()
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn1.layer.cornerRadius = 12
        btn2.layer.cornerRadius = 12
        btn3.layer.cornerRadius = 12
        btn4.layer.cornerRadius = 12
        
        secUserName.text=un
        secPassword.text=pw
        secEmail.text=em
        userMobile.text=mb
        
        if userdefault.object(forKey: secUserName.text!) != nil
        {
        secContent.text=userdefault.object(forKey: secUserName.text!) as! String
        }else{
            secContent.text = ""
        }
        
        context = appDel.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func secUpdate(_ sender: UIButton) {


        var num=0
        if secPassword.text==""||userMobile.text==""{
            num=1
            let alertController = UIAlertController(title: "欄位未齊全", message: "請重新輸入！", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        }
        if num==0{
            let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
            let predicate=NSPredicate(format: "username = '\(secUserName.text!)'")
            fetchRequest.predicate=predicate
            let allusers = try! context.fetch(fetchRequest)
            allusers[0].password=secPassword.text!
            allusers[0].mobile=userMobile.text!
            if secEmail.text != ""{
                allusers[0].email=secEmail.text!
            }else{
                allusers[0].email=""
            }
            appDel.saveContext()
            
            let alertController = UIAlertController(title: "修改成功", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
            alertController.addAction(ok)
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func secDelete(_ sender: UIButton) {
        let fetchRepuest:NSFetchRequest<UserData>=UserData.fetchRequest()
        let predicate=NSPredicate(format: "username = '\(secUserName.text!)'")
        fetchRepuest.predicate=predicate
        let allusers = try! context.fetch(fetchRepuest)
        context.delete(allusers[0])
        appDel.saveContext()
        
        let alertController = UIAlertController(title: "成功刪除", message: "歡迎重辦帳號！", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "確認", style: .destructive){
            (alert: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func secClear(_ sender: UIButton) {
        secPassword.text = ""
        secEmail.text = ""
        userMobile.text = ""
    }
    
    @IBAction func insertContent(_ sender: UIButton) {
        userdefault.set(secContent.text!, forKey: secUserName.text!)
        //同步
        userdefault.synchronize()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
