//
//  ResumoViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/13/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit
import MessageUI

class ResumoViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var obsLabel: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var denunciaView: UIView!
    @IBOutlet weak var tipoDenunciaLabel: UILabel!
    var didFinishAction = false
    
    var mailContent:String {
        return """
        <h4>Olá, Somos do aplicativo evaS e estamos repassando informação sobre algum desperdicio de água (\(dao.denuncia.tipoDenuncia)).</h4>
        <br>Como preservar água é uma vontade de todos estamos pedindo encarecidamente para consertar o problema :).
        O problema se encontra localizado em: <b>\(dao.denuncia.address)</b>
        <p><b>Observações do Usuario:</b> \(dao.denuncia.obsUsuario)</p>
        """
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            var subject:String
            if dao.denuncia.tipoDenuncia == "Mal Uso"
            {
                subject = "Conexão Ilegal"
            }
            else
            {
                subject = dao.denuncia.tipoDenuncia
            }
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            mail.setToRecipients(["bruno.leaoteixeira@gmail.com"])
            mail.setSubject("Denuncia -  \(subject)")
            mail.setMessageBody(mailContent, isHTML: true)
            
            
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
    
    @IBOutlet weak var descReview: UITextView!
    @IBOutlet weak var check: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        denunciaView.layer.cornerRadius = 10
        
        descReview.text = dao.denuncia.obsUsuario
        tipoDenunciaLabel.text = dao.denuncia.tipoDenuncia
        locationLabel.text = dao.denuncia.address
        obsLabel.text = dao.denuncia.obsUsuario
        
        check.layer.shadowColor = UIColor.black.cgColor
        check.layer.shadowRadius = 1
        check.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        check.layer.shadowOpacity = 0.5
        descReview.layer.cornerRadius = 5
        
        dao.denuncias.append(dao.denuncia)
        
        
        if tipoDenunciaLabel.text == "Conexão Ilegal" {
            
            denunciaView.backgroundColor = UIColor(named: "water")
            
        } else if tipoDenunciaLabel.text == "Vazamento" {
            
            denunciaView.backgroundColor = UIColor(named: "green")
            
        } else if tipoDenunciaLabel.text == "Falta d'Água" {
            
            denunciaView.backgroundColor = UIColor(named: "purple")
        } else {
            
            denunciaView.backgroundColor = UIColor(named: "redish")
        }
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func goToHomePage() {
        
        let tipoDenunciaView: FirstNavController = self.storyboard?.instantiateViewController(withIdentifier: "FirstNavController2") as! FirstNavController
        
        self.navigationController?.present(tipoDenunciaView, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        
        
    }
    
    
    
    @IBAction func shareButton(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() as Any
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
        
        
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

