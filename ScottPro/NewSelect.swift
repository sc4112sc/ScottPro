//
//  NewSelect.swift
//  ScottPro
//
//  Created by ios135 on 2018/6/24.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit

class NewSelect: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate {
    
    var newLogin=false
    var newUser=""
    @IBOutlet weak var pv: UIPickerView!
    
    @IBOutlet weak var btnC1: UIButton!
    @IBOutlet weak var btnC2: UIButton!
    
    var shopName=""
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel() 
            pickerLabel?.font = UIFont(name: "<Your Font Name>", size: 20)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = "🍹 "+dArray[row]
        pickerLabel?.textColor = UIColor.white
        pickerLabel?.backgroundColor = UIColor.orange
        return pickerLabel!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let dCollection = dArray.keys
//        let dDrink = Array(dCollection)
        return dArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let dCollection = dArray.keys
//        let dDrink = Array(dCollection)
        mySelect.text = dArray[row]
        
//        let mCollection = dArray.values
//        let dMoney = Array(mCollection)
        money = dMoney[row]
    }
    
    @IBOutlet weak var dPicker: UIPickerView!
    @IBOutlet weak var mySelect: UILabel!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var myCount: UILabel!
    @IBOutlet weak var secContent: UITextView!
    
    @IBAction func calStepper(_ sender: Any) {
        myCount.text=String(Int(myStepper.value))
    }
    
    var mySugar = "全糖"
    var myIce = "正常"
    
    
    @IBAction func calSugar(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            mySugar = "全糖"
        }else if sender.selectedSegmentIndex == 1 {
            mySugar = "少糖"
        }else if sender.selectedSegmentIndex == 2 {
            mySugar = "半糖"
        }else if sender.selectedSegmentIndex == 3 {
            mySugar = "微糖"
        }else{
            mySugar = "無糖"
        }
        
    }
    
    @IBAction func calIce(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            myIce = "正常"
        }else if sender.selectedSegmentIndex == 1 {
            myIce = "少冰"
        }else if sender.selectedSegmentIndex == 2 {
            myIce = "微冰"
        }else {
            myIce = "去冰"
        }
    }
    

    
    @IBOutlet weak var cupSeg: UISegmentedControl!
    
    var myItems:[String]=[]
    
    var x = 1
    
    @IBAction func inputCar(_ sender: UIButton) {

        
        
        
        if myCount.text == "0" || mySelect.text == ""{
            let alertController = UIAlertController(title: "輸入錯誤", message: "請輸入飲料或杯數", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }else{
            
            if cupSeg.selectedSegmentIndex == 0{
                finalText=String(x)+"."+"  "+mySelect.text!+"  "+"大杯"+mySugar+myIce+"  "+myCount.text!+"杯"+"  "+"共"+String(money*Int(myStepper.value))+"元"
                if secContent.text==""
                {
                    x = x+1
                    secContent.text=finalText
                    car=true
                    
                    allMoney=money*Int(myStepper.value)
                }else
                {
                    x = x+1
                    secContent.text=secContent.text+"\n"+finalText
                    car=true
                    
                             allMoney=allMoney+money*Int(myStepper.value)
                }
            }else{
                finalText=String(x)+"."+"  "+mySelect.text!+"  "+"中杯"+mySugar+myIce+"  "+myCount.text!+"杯"+"  "+"共"+String((money-5)*Int(myStepper.value))+"元"
                if secContent.text==""
                {
                    x = x+1
                    secContent.text=finalText
                    car=true
                    
                    allMoney=(money-5)*Int(myStepper.value)
                }else
                {
                    x = x+1
                    secContent.text=secContent.text+"\n"+finalText
                    car=true
                    
                    allMoney=allMoney+(money-5)*Int(myStepper.value)
                    
                }
            }
            

        }
        

    }
    @IBAction func clear(_ sender: Any) {
        secContent.text=""
        x=1
        car=false
    }
    var finalText=""
    var money=0
    var allMoney=0
//    var dArray:[String:Int]=["阿薩姆紅茶":25,"茉莉綠茶":25,"四季春青茶":25,"黃金烏龍":25,"波霸綠茶":35,"波霸紅茶":35,"微檸檬紅":35,"微檸檬青":35,"檸檬綠":45,"檸檬青":45,"梅子綠":45,"8冰綠":45,"多多綠":45,"冰淇淋紅茶":45,"旺來紅":45,"旺來青":45,"鮮柚綠(季節限定)":55]
    
    var dArray:[String]=["阿薩姆紅茶","茉莉綠茶","四季春青茶","黃金烏龍","波霸綠茶","波霸紅茶","微檸檬紅","微檸檬青","檸檬綠","檸檬青","梅子綠","8冰綠","多多綠","冰淇淋紅茶","旺來紅","旺來青","鮮柚綠(季節限定)"]
    var dMoney:[Int]=[25,25,25,25,35,35,35,35,45,45,45,45,45,45,45,45,55]
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    var car = false
    
    @IBAction func calCheck(_ sender: UIBarButtonItem) {
        if car==false {
            let alertController = UIAlertController(title: "選擇未齊全", message: "請輸入飲料訂單", preferredStyle: .alert)
            let ok = UIAlertAction(title: "繼續選擇", style: .cancel, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        }else{

            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "check") as! CheckViewController
            
            if(newLogin==true){
                vc.myAllMoney=allMoney
                vc.myUser=newUser
                vc.myFinalText=secContent.text
                vc.myShopName=shopName
                
                vc.checkLogin=true
                vc.isLogin=true
                show(vc, sender: self)
            }else{
                vc.myAllMoney=allMoney
                
                vc.myFinalText=secContent.text
                vc.myShopName=shopName
                
                show(vc, sender: self)
            }
            
        }
        
    }
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        secContent.delegate = self
        
        btnC1.layer.cornerRadius = 12
        btnC2.layer.cornerRadius = 12
        
        if count==0{
             dArray=["阿薩姆紅茶","茉莉綠茶","四季春青茶","黃金烏龍","波霸綠茶","波霸紅茶","微檸檬紅","微檸檬青","檸檬綠","檸檬青","梅子綠","8冰綠","多多綠","冰淇淋紅茶","旺來紅","旺來青","鮮柚綠(季節限定)"]
             dMoney=[25,25,25,25,35,35,35,35,45,45,45,45,45,45,45,45,55]
        }else if count==1{
            dArray=["茉香綠茶","大正紅茶","英倫伯爵紅茶","初露青茶","決明大麥","紅茶拿鐵","綠茶拿鐵","伯爵紅茶拿鐵","珍珠紅茶拿鐵","布丁紅茶拿鐵","珍珠鮮奶","手炒黑糖鮮奶","大甲芋頭鮮奶","草莓鮮奶","甘蔗青茶","原鄉冬瓜茶","香柚綠茶"]
            dMoney=[25,25,30,30,25,50,50,50,55,55,60,60,60,55,45,25,50]
        }else if count==2{
            dArray=["觀音拿鐵","珍珠紅豆拿鐵","翡翠檸檬","珍珠奶茶","新鮮水果茶","芋香翡翠拿鐵","冬瓜檸檬","檸檬紅茶","檸檬蜜茶","鮮桔檸檬","蔗香紅茶","茉香綠茶","特級翡翠綠","碳燒鐵觀音","珍珠紅茶","包種清茶","珍珠綠茶"]
            dMoney=[55,65,55,49,55,55,49,50,50,55,25,30,35,35,35,35,39]
        }else{
            dArray=["愛文芒果冰沙","奇異果綠茶","奇異果冰鑽","蕃茄梅","新鮮水果茶","翡翠檸檬","柚美粒","蔓越梅冰醋","蔓越梅冰茶","蔓美粒","金桔粒脆纖果","百香多輕飲","高纖綠茶","葡萄柚舒活","高纖奶綠","椰果奶茶","鮮奶綠"]
            dMoney=[60,60,60,45,50,45,50,50,45,60,45,45,20,25,30,35,45]
        }
        
        pv.selectRow(5, inComponent: 0, animated: true)
        
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

}
