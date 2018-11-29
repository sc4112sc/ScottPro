//
//  ChangeViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/10/2.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class ChangeViewController: UIViewController {
    
    var myUser=""
    var myTime=""
    var myCheep=""
    var bgs=["tableC01","tableC02","tableC03"]
    
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    @IBOutlet weak var myBg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi!"+myTime)
        if myCheep=="任選飲料一杯"{
            myBg.image=UIImage(named: bgs[0])
        }else if myCheep=="單筆訂單享八折優惠"{
            myBg.image=UIImage(named: bgs[1])
        }else{
            myBg.image=UIImage(named: bgs[2])
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var time1=""
    var time2=""
    var time3=""
    
    var mytime1=[String]()
    var mytime2=[String]()
    var mytime3=[String]()
    
    var finalTime1=""
    var finalTime2=""
    var finalTime3=""
    
     @IBAction func calChange(_ sender: Any) {
        
        
        //CoreData取得表單列表
        let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
        let predicate=NSPredicate(format: "username = '\(myUser)'")
        fetchRequest.predicate=predicate
        var allusers = try! context.fetch(fetchRequest)
        
        time1=allusers[0].time1_3days!
        time2=allusers[0].time2_3days!
        time3=allusers[0].time3_3days!
        
        mytime1=time1.components(separatedBy: " ")
        mytime2=time2.components(separatedBy: " ")
        mytime3=time3.components(separatedBy: " ")
        

        var r = -1
        
        if myCheep=="任選飲料一杯"{
            allusers[0].cheep01=allusers[0].cheep01-1
            for i in mytime1{
                r=r+1
                if i == myTime{
                    mytime1.remove(at: r)
                    

                    
                }
            }

        }else if myCheep=="單筆訂單享八折優惠"{
            allusers[0].cheep02=allusers[0].cheep02-1
            
            for i in mytime2{
                r=r+1
                if i == myTime{
                    mytime2.remove(at: r)
                    

                }
            }
        }else{
            allusers[0].cheep03=allusers[0].cheep03-1
            
            for i in mytime3{
                r=r+1
                if i == myTime{
                    mytime3.remove(at: r)
                    
 
                }
            }
        }
        
        

        
        
        for i in mytime1{
            finalTime1=finalTime1+i+" "
        }
        for i in mytime2{
            finalTime2=finalTime2+i+" "
        }
        for i in mytime3{
            finalTime3=finalTime3+i+" "
        }
        
        
        allusers[0].time1_3days=finalTime1
        allusers[0].time2_3days=finalTime2
        allusers[0].time3_3days=finalTime3
        
        appDel.saveContext()
 
        print("f1:"+finalTime1)
        print("f2:"+finalTime2)
        print("f3:"+finalTime3)
        
        let alertController = UIAlertController(title: "成功兌換", message: "祝您愉快", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "確認", style: .cancel){
            (alert: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         context = appDel.persistentContainer.viewContext
        
         finalTime1=""
         finalTime2=""
         finalTime3=""
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
