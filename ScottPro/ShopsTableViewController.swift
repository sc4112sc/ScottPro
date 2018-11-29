//
//  ShopsTableViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/8/8.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit

class ShopsTableViewController: UITableViewController {
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    var shopsLogin=false
    var shopUser=""
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        img1.clipsToBounds = true
        img1.layer.cornerRadius = 30
        
        img2.clipsToBounds = true
        img2.layer.cornerRadius = 30
        
        img3.clipsToBounds = true
        img3.layer.cornerRadius = 30
        
        img4.clipsToBounds = true
        img4.layer.cornerRadius = 30
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let selectVC=storyboard?.instantiateViewController(withIdentifier: "newSelect") as! NewSelect
        
        if indexPath.row==0{
            
            if (shopsLogin==true){
                selectVC.shopName="50嵐"
                selectVC.newUser=shopUser
                selectVC.newLogin=true
                selectVC.count=0
                show(selectVC, sender: self)
            }else{
                selectVC.shopName="50嵐"
                
                selectVC.count=0
                show(selectVC, sender: self)
            }
            

        }else if indexPath.row==1{
            if (shopsLogin==true){
                selectVC.shopName="迷客夏"
                selectVC.newUser=shopUser
                selectVC.newLogin=true
                selectVC.count=1
                show(selectVC, sender: self)
            }else{
                selectVC.shopName="迷客夏"
                
                selectVC.count=1
                show(selectVC, sender: self)
            }
            
        }else if indexPath.row==2{
            if (shopsLogin==true){
                selectVC.shopName="茶湯會"
                selectVC.newUser=shopUser
                selectVC.newLogin=true
                selectVC.count=2
                show(selectVC, sender: self)
            }else{
                selectVC.shopName="茶湯會"
                
                selectVC.count=2
                show(selectVC, sender: self)
            }
        }else{
            if (shopsLogin==true){
                selectVC.shopName="大苑子"
                selectVC.newUser=shopUser
                selectVC.newLogin=true
                selectVC.count=3
                show(selectVC, sender: self)
            }else{
                selectVC.shopName="大苑子"
                
                selectVC.count=3
                show(selectVC, sender: self)
            }
            
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
