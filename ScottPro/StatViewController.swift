//
//  StatViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/10/2.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class StatViewController: UIViewController {
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    
    var myStar=0
    var myUser=""
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    var myTimer:Timer!
    
    var myImgs=["cheepBG01","cheepBG02","cheepBG03"]
    var dicel=arc4random_uniform(3)
    
    var nowTime=""
    var dayAfter3String=""
    
    @IBOutlet weak var giveBtn: UIButton!
    @IBOutlet weak var myBtn: UIButton!
    @IBAction func calGive(_ sender: Any) {
        
        let formatter=DateFormatter()
        formatter.locale=Locale.ReferenceType.system
        formatter.timeZone=TimeZone.ReferenceType.system
        formatter.dateFormat = "MM月dd日HH:mm "
        nowTime=formatter.string(from: Date())
        
        let dayAfter3=Date().addingTimeInterval(60*60*24)
        dayAfter3String=formatter.string(from: dayAfter3)
        print(dayAfter3String)
        //CoreData取得表單列表
        let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
        let predicate=NSPredicate(format: "username = '\(myUser)'")
        fetchRequest.predicate=predicate
        var allusers = try! context.fetch(fetchRequest)
        allusers[0].star=0
        
        
        switch dicel {
        case 0:
            allusers[0].cheep01=allusers[0].cheep01+1
            if allusers[0].time1_3days==""{
                allusers[0].time1_3days=dayAfter3String
            }else{
                allusers[0].time1_3days=allusers[0].time1_3days!+dayAfter3String
            }

            break
        case 1:
            allusers[0].cheep02=allusers[0].cheep02+1

            if allusers[0].time2_3days==""{
                allusers[0].time2_3days=dayAfter3String
            }else{
                allusers[0].time2_3days=allusers[0].time2_3days!+dayAfter3String
            }
            break
        case 2:
            allusers[0].cheep03=allusers[0].cheep03+1

            if allusers[0].time3_3days==""{
                allusers[0].time3_3days=dayAfter3String
            }else{
                allusers[0].time3_3days=allusers[0].time3_3days!+dayAfter3String
            }
            break
        default:
            break
        }
        appDel.saveContext()

        
        myStar=0
        star1.isHidden=true
        star2.isHidden=true
        star3.isHidden=true
        star4.isHidden=true
        star5.isHidden=true
        giveBtn.alpha=0.5
        giveBtn.isEnabled=false
        
        myTimer.invalidate()
        
  

        
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "give") as! GiveViewController
        
        selectVC.myImgs=myImgs[Int(dicel)]
        
        show(selectVC, sender: self)
        

    }
    
    var aa=0
    var bb=0
    var cc=0
    
    var finalTime1=""
    var finalTime2=""
    var finalTime3=""
    
    var mytime1A=[String]()
    var mytime2A=[String]()
    var mytime3A=[String]()
    
    var time1A=""
    var time2A=""
    var time3A=""
    
    var bTime1=Date()
    var bTime2=Date()
    var bTime3=Date()
    
    @IBAction func calAllCheep(_ sender: Any) {
        
        


        //CoreData取得表單列表
        let fetchRequest0:NSFetchRequest<UserData>=UserData.fetchRequest()
        let predicate0=NSPredicate(format: "username = '\(myUser)'")
        fetchRequest0.predicate=predicate0
        var allusers0 = try! context.fetch(fetchRequest0)


        let formatter=DateFormatter()
        formatter.locale=Locale.ReferenceType.system
        formatter.timeZone=TimeZone.ReferenceType.system
        formatter.dateFormat = "MM月dd日HH:mm"
        var nowTime=formatter.string(from: Date())
        var nowTimeB=formatter.date(from: nowTime)
        //

        aa=Int(allusers0[0].cheep01)
        bb=Int(allusers0[0].cheep02)
        cc=Int(allusers0[0].cheep03)



            //
        if allusers0[0].time1_3days==""{
            time1A=""
        }else{
            time1A=allusers0[0].time1_3days!
            mytime1A=time1A.components(separatedBy: " ")

            if aa != 0 {


                for i in 0...(aa-1){
                    
                    if let indexNil=mytime1A.index(of: ""){
                        mytime1A.remove(at: indexNil)
                    }
                    
                    bTime1=formatter.date(from: mytime1A[i])!
                    if bTime1 < nowTimeB!{
                        allusers0[0].cheep01=allusers0[0].cheep01-1
                        mytime1A.remove(at: i)
                        
                        for r in mytime1A{
                            finalTime1=finalTime1+r+" "
                        }
                        
                        allusers0[0].time1_3days=finalTime1

                    }

                }
            }

            

        }

        if allusers0[0].time2_3days==""{
            time2A=""
        }else{
            time2A=allusers0[0].time2_3days!
            mytime2A=time2A.components(separatedBy: " ")


            if bb != 0 {
                for i in 0...(bb-1){
                    
                    if let indexNil=mytime2A.index(of: ""){
                        mytime2A.remove(at: indexNil)
                    }
                    
                    bTime2=formatter.date(from: mytime2A[i])!
                    if bTime2 < nowTimeB!{
                        allusers0[0].cheep02=allusers0[0].cheep02-1
                        mytime2A.remove(at: i)
                        
                        for r in mytime2A{
                            finalTime2=finalTime2+r+" "
                        }
                        
                        allusers0[0].time2_3days=finalTime2
                    }
                }
            }



        }

        if allusers0[0].time3_3days==""{
            time3A=""
        }else{
            time3A=allusers0[0].time3_3days!
            mytime3A=time3A.components(separatedBy: " ")

            if cc != 0 {
                for i in 0...(cc-1){
                    
                    if let indexNil=mytime3A.index(of: ""){
                        mytime3A.remove(at: indexNil)
                    }

                    
                    bTime3=formatter.date(from: mytime3A[i])!
                    if bTime3 < nowTimeB!{
                        allusers0[0].cheep03=allusers0[0].cheep03-1
                        mytime3A.remove(at: i)
                        
                        for r in mytime3A{
                            finalTime3=finalTime3+r+" "
                        }
                        
                        allusers0[0].time3_3days=finalTime3
                    }
                }
            }



        }








            appDel.saveContext()
        
            
        

        
        let selectVC=storyboard?.instantiateViewController(withIdentifier: "allCheep") as! AllCheepViewController
        
        selectVC.myUser=myUser
        show(selectVC, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       
        
        
        context=appDel.persistentContainer.viewContext
        
        
        let allUser = try! context.fetch(UserData.fetchRequest())
        
        for user in allUser as! [UserData]
        {
            if user.username==myUser{
                
                
                myStar=Int(user.star)
                break
            }
            
        }
        
        if myStar==5 {
            if myTimer==nil{
                
            }else{
                myTimer.invalidate()
            }
        
           giveBtn.isEnabled=true
           giveBtn.alpha=1.0;
            myTimer=Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
            
            myTimer.fire()
        }else{
            giveBtn.alpha=0.5
            giveBtn.isEnabled=false
            
            
        }
        
        switch myStar {
        case 0:
            star1.isHidden=true
            star2.isHidden=true
            star3.isHidden=true
            star4.isHidden=true
            star5.isHidden=true
            break
        case 1:
            star1.isHidden=false
            star2.isHidden=true
            star3.isHidden=true
            star4.isHidden=true
            star5.isHidden=true
            break
        case 2:
            star1.isHidden=false
            star2.isHidden=false
            star3.isHidden=true
            star4.isHidden=true
            star5.isHidden=true
            break
        case 3:
            star1.isHidden=false
            star2.isHidden=false
            star3.isHidden=false
            star4.isHidden=true
            star5.isHidden=true
            break
        case 4:
            star1.isHidden=false
            star2.isHidden=false
            star3.isHidden=false
            star4.isHidden=false
            star5.isHidden=true
            break
        case 5:
            star1.isHidden=false
            star2.isHidden=false
            star3.isHidden=false
            star4.isHidden=false
            star5.isHidden=false
            break
        default:
            break
           
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func timerRun(){
        myBtn.transform=CGAffineTransform(scaleX: 2.0, y: 2.0)
        UIView.animate(withDuration: 1.5, delay: 0, options: .allowUserInteraction, animations: {
            self.myBtn.transform = .identity
        }, completion: nil)
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
