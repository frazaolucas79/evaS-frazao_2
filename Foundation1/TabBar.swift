//
//  TabBar.swift
//  Foundation1
//
//  Created by Foundation_28 on 5/10/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isToolbarHidden = true
        
        
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
