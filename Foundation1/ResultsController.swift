//
//  ResultsController.swift
//  Foundation1
//
//  Created by Foundation_38 on 5/14/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class ResultsController: UIViewController {
    

    
    @IBAction func goToNextPage(_ sender: Any) {
        presentAfterResponseScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAfterResponseScreen(){
        let storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let tabBarVc: TabBar=storyboard.instantiateViewController(withIdentifier:"TabBar") as! TabBar
        self.present(tabBarVc, animated: true, completion: nil)
        
    }


}
