//
//  CheckDetailViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/9/25.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit
import CoreData
class CheckDetailViewController: UIViewController {
    @IBOutlet weak var myText: UITextView!
    @IBOutlet weak var addString: UITextView!
    var myItems=""
    
    var myMany=""
    var userdefault=UserDefaults()
    
    var myToF=false
    
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    //
    
    @IBOutlet weak var btn1: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title=""
        
        print(myMany)
        if (myToF==true) {
            cancelOut.isHidden=true
            cancelAllOut.isHidden=true
            cancel2Out.isHidden=false
        }else{
            cancelOut.isHidden=false
            cancelAllOut.isHidden=false
            cancel2Out.isHidden=true
        }
        
        //core data
        context=appDel.persistentContainer.viewContext
        
        myText.text=myItems
        
        if userdefault.object(forKey: myItems) != nil
        {
            addString.text=userdefault.object(forKey: myItems) as! String
        }else{
            addString.text = ""
        }
        
        
        btn1.layer.cornerRadius = 12
        cancelOut.layer.cornerRadius = 12
        cancel2Out.layer.cornerRadius = 12
        cancelAllOut.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calAdd(_ sender: Any) {
        userdefault.set(addString.text!, forKey: myItems)
        //同步
        userdefault.synchronize()
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        let fetchRepuest:NSFetchRequest<Items>=Items.fetchRequest()
        let predicate=NSPredicate(format: "many = '\(myMany)'")
        fetchRepuest.predicate=predicate
        let allItems = try! context.fetch(fetchRepuest)
        context.delete(allItems[0])
        appDel.saveContext()
        
        myText.text=""
        addString.text=""
        
        let alertController = UIAlertController(title: "成功刪除", message: "歡迎重新下單", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "確認", style: .cancel, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancelAll(_ sender: Any) {
        let fetchRepuest:NSFetchRequest<Items>=Items.fetchRequest()
        let allItems = try! context.fetch(fetchRepuest)
        for result in allItems{
            context.delete(result)
        }
        myText.text=""
        addString.text=""
        
        let alertController = UIAlertController(title: "成功刪除", message: "歡迎重新下單", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "確認", style: .cancel, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancel2(_ sender: Any) {
        myText.text=""
        addString.text=""
        
        let alertController = UIAlertController(title: "成功取消", message: "歡迎重新下單", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "確認", style: .cancel){
            (alert: UIAlertAction!) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! Home
            self.show(vc, sender: self)

        }
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBOutlet weak var cancelOut: UIButton!
    
    @IBOutlet weak var cancelAllOut: UIButton!
    @IBOutlet weak var cancel2Out: UIButton!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
