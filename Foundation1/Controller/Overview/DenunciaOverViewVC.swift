//
//  DenunciaOverViewVC.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/19/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class DenunciaOverViewVC: UIViewController {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var obserView: UITextView!
    @IBAction func unresolve(_ sender: Any) {
       // dao.denuncias[0].status = "Em aberto"
       // dao.save(denuncias: dao.denuncias, in: "Denuncias")
       // self.view.setNeedsLayout()
    }
    @IBAction func resolved(_ sender: Any) {
       // dao.denuncias[0].status = "Fechado"
      //  dao.save(denuncias: dao.denuncias, in: "Denuncias")
        self.view.setNeedsLayout()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      //  obserView.layer.cornerRadius = 10
      //  obserView.text = dao.denuncias[0].obsUsuario
       // status.text = dao.denuncias[0].status
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
