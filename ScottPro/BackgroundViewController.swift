//
//  BackgroundViewController.swift
//  ScottPro
//
//  Created by ios135 on 2018/6/10.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class BackgroundViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    //建立元組
    var myData:[(myName:String,myPassword:String,myEmail:String,myMobile:String)] = []
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text="帳號:\(myData[indexPath.row].myName)\t密碼:\(myData[indexPath.row].myPassword)"
        cell.detailTextLabel?.text="E-mail:\(myData[indexPath.row].myEmail)\t行動電話:\(myData[indexPath.row].myMobile)"
        
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let secVC=storyboard?.instantiateViewController(withIdentifier: "SECOND") as! SecendViewController
        
        secVC.un=myData[indexPath.row].myName
        secVC.pw=myData[indexPath.row].myPassword
        secVC.em=myData[indexPath.row].myEmail
        secVC.mb=myData[indexPath.row].myMobile
        
        show(secVC, sender: self)
    }
    @IBAction func gohome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    //可重複載入
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData=[]
        
        context = appDel.persistentContainer.viewContext
        let allusers = try! context.fetch(UserData.fetchRequest())
        for user in allusers as! [UserData]
        {
            //如果手機不為空
            if let mb = user.mobile
            {
                myData.append((user.username!,user.password!,user.email!,user.mobile!))
                
            }else{
                myData.append((user.username!,user.password!,user.email!,""))
            }
            
        }
        //重新載入
        myTableView.reloadData()


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate=self
        myTableView.dataSource=self

        
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
