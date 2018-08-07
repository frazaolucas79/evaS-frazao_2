//
//  DenunciaViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 5/11/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit
import MessageUI
class DenunciaViewController: UIViewController, MFMailComposeViewControllerDelegate {
   
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            mail.setToRecipients(["bruno.leaoteixeira@gmail.com"])
            mail.setSubject("Denuncia Vazamento!")
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func reportMail(_ sender: Any) {
        sendEmail()
    }
    @IBAction func sabespButton(_ sender: Any) {
    
        if let url = URL(string: "https://www9.sabesp.com.br/agenciavirtual/pages/home/paginainicial.iface") {
            UIApplication.shared.open(url)
        }
    
    
    
    }
    @IBAction func cedaeButton(_ sender: Any) {
   
        if let url = URL(string: "http://www.cedae.com.br") {
            UIApplication.shared.open(url)
        }
    
    
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
