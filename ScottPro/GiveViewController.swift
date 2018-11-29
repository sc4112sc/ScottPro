//
//  GiveViewController.swift
//  ScottPro
//
//  Created by 李書賢 on 2018/10/2.
//  Copyright © 2018年 Awei. All rights reserved.
//

import UIKit

class GiveViewController: UIViewController {

    var myImgs=""
    @IBOutlet weak var imgs: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgs.image=UIImage(named: myImgs)
        
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
