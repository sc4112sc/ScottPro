//
//  AllCheepViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/10/2.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData

class cheepUITableViewCell: UITableViewCell{

    @IBOutlet weak var t01: UILabel!
    @IBOutlet weak var t02: UILabel!
    
    @IBOutlet weak var t03: UILabel!
}

class AllCheepViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    var manyCell=0
    
    var cheepA:[String]=[]
    
    
    var a=0
    var b=0
    var c=0
    

    
    var mytime1=[String]()
    var mytime2=[String]()
    var mytime3=[String]()
    

    
    var finalTime=[String]()
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        
        return manyCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cheepUITableViewCell
        

        
    
        
        cell.t01.text=cheepA[indexPath.row]
        
        cell.t02.text="期限："+finalTime[indexPath.row]
    

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVC=storyboard?.instantiateViewController(withIdentifier: "change") as! ChangeViewController
        secVC.myCheep=cheepA[indexPath.row]
        secVC.myTime=finalTime[indexPath.row]
        secVC.myUser=myUser
        show(secVC, sender: self)
    }
    
    var myUser=""
    
    var time1=""
    var time2=""
    var time3=""
    

    
    @IBOutlet weak var noText: UILabel!
    @IBOutlet weak var noBg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
  
        
        cheepA=[]
        mytime1=[]
        mytime2=[]
        mytime3=[]
        finalTime=[]
        
        context = appDel.persistentContainer.viewContext

        
        //CoreData取得表單列表
        let fetchRequest:NSFetchRequest<UserData>=UserData.fetchRequest()
        let predicate=NSPredicate(format: "username = '\(myUser)'")
        fetchRequest.predicate=predicate
        var allusers = try! context.fetch(fetchRequest)
    manyCell=Int(allusers[0].cheep01+allusers[0].cheep02+allusers[0].cheep03)
        
        a=Int(allusers[0].cheep01)
        b=Int(allusers[0].cheep02)
        c=Int(allusers[0].cheep03)
        
        
 
        if allusers[0].time1_3days==""{
           // time1=""
        }else{
            time1=allusers[0].time1_3days!
            mytime1=time1.components(separatedBy: " ")
            
        }
        
        if allusers[0].time2_3days==""{
            //time2=""
        }else{
            time2=allusers[0].time2_3days!
            mytime2=time2.components(separatedBy: " ")
            
        }
        
        if allusers[0].time3_3days==""{
            //time3=""
        }else{
            time3=allusers[0].time3_3days!
            mytime3=time3.components(separatedBy: " ")
            
        }
        
        
        for i in mytime1{
            if let indexNil=mytime1.index(of: ""){
                mytime1.remove(at: indexNil)
            }
        }
        for i in mytime2{
            if let indexNil=mytime2.index(of: ""){
                mytime2.remove(at: indexNil)
            }
        }
        for i in mytime3{
            if let indexNil=mytime3.index(of: ""){
                mytime3.remove(at: indexNil)
            }
        }
            
        
        
          
            
        finalTime=mytime1+mytime2+mytime3

        
            print(mytime1)
            print(mytime2)
            print(mytime3)
            print(finalTime)
        

        
        
        
        if a != 0 {
            
            
            for i in 1...a{
                cheepA.append("任選飲料一杯")
                
            }
        }
        
        if b != 0 {
            for i in 1...b{
                cheepA.append("單筆訂單享八折優惠")
            }
        }
        
        if c != 0 {
            for i in 1...c{
                cheepA.append("單筆訂單享六折優惠")
            }
        }
        
        
        

        
        if manyCell==0{
            noBg.isHidden=false
            noText.isHidden=false
        }else{
            noBg.isHidden=true
            noText.isHidden=true
        }
        //重新載入
        myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calClair(_ sender: Any) {
        
               let selectVC=storyboard?.instantiateViewController(withIdentifier: "clair") as! ClairViewController
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
