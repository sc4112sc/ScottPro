//
//  ScoSubmit.swift
//  ScottPro
//
//  Created by ios135 on 2018/6/3.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData

class ScoSubmit: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var checkPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var submitH: UIButton!
    @IBOutlet weak var cancelSubmit: UIButton!
    
    //CoreData
    var context:NSManagedObjectContext!
    let appDel = UIApplication.shared.delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()
        username.delegate = self
        password.delegate = self
        checkPassword.delegate = self
        email.delegate = self
        mobile.delegate = self
        submitH.isEnabled=false
        //使這個欄位的由標在前
        username.becomeFirstResponder()
        
        submitH.layer.cornerRadius = 12
        cancelSubmit.layer.cornerRadius = 12
        
        //CoreData
        
        context=appDel.persistentContainer.viewContext
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == username{
            if username.text=="" {
                message(myTitle: "輸入錯誤", myMessage: "帳號欄位不可為空白！")
                username.becomeFirstResponder()
            }else{
                password.becomeFirstResponder()
            }
        }else if textField == password{
            if password.text=="" {
                message(myTitle: "輸入錯誤", myMessage: "密碼欄位不可為空白！")
                password.becomeFirstResponder()
            }else{
                checkPassword.becomeFirstResponder()
            }
        }else if textField == checkPassword{
            if checkPassword.text=="" {
                message(myTitle: "輸入錯誤", myMessage: "確認帳號欄位不可為空白！")
                checkPassword.becomeFirstResponder()
            }else{
                if password.text==checkPassword.text{
                    mobile.becomeFirstResponder()
                }else{
                    password.text=""
                    checkPassword.text=""
                    message(myTitle: "驗證錯誤", myMessage: "確認密碼與密碼不同請重新輸入！")
                    password.becomeFirstResponder()
                }
            }
        }else if textField == mobile{
            if mobile.text=="" {
                message(myTitle: "輸入錯誤", myMessage: "電話欄位不可為空白！")
                mobile.becomeFirstResponder()
            }else{
                email.becomeFirstResponder()
                
            }
        }else if textField == email{
            email.resignFirstResponder()
            submitH.isEnabled=true
            
        }
        return true
    }
    
    var usernameIsV=false
    var passwordIsV=false
    var ckeckPasswordIsV=false
    var phoneIsV=false
    
    @IBAction func submit(_ sender: UIButton) {
 
        if password.text != checkPassword.text {
            message(myTitle: "密碼錯誤", myMessage: "密碼不相同")
            password.text=""
            checkPassword.text=""
        }
        
        usernameIsV=isPasswordValid(username.text!)
        passwordIsV=isPasswordValid(password.text!)
        ckeckPasswordIsV=isPasswordValid(checkPassword.text!)
        phoneIsV=isPasswordValid2(mobile.text!)
        
        if usernameIsV==false{
            message(myTitle: "帳號格式錯誤", myMessage: "必須包含字母與數字，至少為六位")
            username.text=""
        }
        
        if passwordIsV==false{
            message(myTitle: "密碼格式錯誤", myMessage: "必須包含字母與數字，至少為六位")
            password.text=""
        }
        
        if ckeckPasswordIsV==false{
            message(myTitle: "密碼格式錯誤", myMessage: "必須包含字母與數字，至少為六位")
            checkPassword.text=""
        }
        
        if phoneIsV==false{
            message(myTitle: "電話格式錯誤", myMessage: "號碼必須為十位")
            mobile.text=""
        }
        
        
        if usernameIsV==true&&passwordIsV==true&&ckeckPasswordIsV==true&&phoneIsV==true{
            
            
            
            
            let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
            let allusers=try! context.fetch(fetchRequest)
            var num=0
            
            for us in allusers{
                if us.username==username.text! {
                    
                    username.text=""
                    password.text=""
                    checkPassword.text=""
                    mobile.text=""
                    username.becomeFirstResponder()
                    self.message(myTitle: "註冊錯誤", myMessage: "此帳號已被註冊請重新輸入！")
                    password.becomeFirstResponder()
                    num=1
                }
            }
            
            if num==0{
                //CoreData取得表單列表
                let user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context) as! UserData
                //CoreData寫入資料並儲存
                user.username=username.text!
                user.password=password.text!
                user.mobile=mobile.text!
                if email.text != ""
                {
                    user.email = email.text!
                }
                user.star=0
                user.cheep01=0
                user.cheep02=0
                user.cheep03=0
                
                user.time1_3days=""
                user.time2_3days=""
                user.time3_3days=""
                appDel.saveContext()
                
                dismiss(animated: true, completion: nil)
            }
            
            
            
            
            
            
            
            
            
            
        }
        
        
      
        
        
    }
    
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isPasswordValid2(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)[\\d]{10,10}$")
        return passwordTest.evaluate(with: password)
    }
    
    
    
    
    @IBAction func cancelSubmit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func message(myTitle:String,myMessage:String) {
        let alertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
