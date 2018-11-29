//
//  MyCheckViewController.swift
//  ScottPro
//
//  Created by ios135 on 2018/8/19.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class MyCheckViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    @IBOutlet weak var myTableView: UITableView!
    var myData:[(myShop:String,myDrink:String,myMoney:String,myTime:String,myMany:String)] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text="商家:\(myData[indexPath.row].myShop)\t\t金額:\(myData[indexPath.row].myMoney)"
        cell.detailTextLabel?.text="訂單時間:\(myData[indexPath.row].myTime)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let fetchRepuest:NSFetchRequest<Items>=Items.fetchRequest()
            let predicate=NSPredicate(format: "many = '\(myData[indexPath.row].myMany)'")
            fetchRepuest.predicate=predicate
            let allItems = try! context.fetch(fetchRepuest)
            context.delete(allItems[0])
            appDel.saveContext()
            
            myData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
    
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let secVC=storyboard?.instantiateViewController(withIdentifier: "checkDetail") as! CheckDetailViewController
        secVC.myItems=myData[indexPath.row].myDrink
        secVC.myMany=myData[indexPath.row].myMany
        show(secVC, sender: self)
    }
    

    @IBAction func myDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData=[]
        
        context = appDel.persistentContainer.viewContext
        let allItems = try! context.fetch(Items.fetchRequest())
        
        for item in allItems as! [Items]
        {
            
    
        myData.append((item.shop!,item.drink!,item.money!,item.time!,item.many!))
                
    
            
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
