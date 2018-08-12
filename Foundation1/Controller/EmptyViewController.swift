//
//  EmptyViewController.swift
//  Foundation1
//
//  Created by Lucas Nascimento on 11/08/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    func setupView() {
        Bundle.main.loadNibNamed("EmptyViewController", owner: self, options: nil)
        view.frame = self.frame
        addSubview(view)
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
