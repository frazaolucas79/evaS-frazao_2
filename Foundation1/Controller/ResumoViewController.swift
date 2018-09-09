//
//  ResumoViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/13/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit
import MessageUI

class ResumoViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var obsLabel: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var denunciaView: UIView!
    @IBOutlet weak var tipoDenunciaLabel: UILabel!
    
    var didFinishAction = false
    
    var mailContent:String {
        return """
        <h4>Olá, somos do aplicativo evaS e estamos repassando informação sobre algum desperdício de água (\(dao.denuncia.tipoDenuncia)).</h4>
        <br>Como preservar água é uma vontade de todos, estamos pedindo encarecidamente que o problema seja resolvido :).
        O problema se encontra localizado em: <b>\(dao.denuncia.address)</b>
        <p><b>Observações do Usuário:</b> \(dao.denuncia.obsUsuario)</p>
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
            mail.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            mail.setToRecipients(["bruno.leaoteixeira@gmail.com"])
            mail.setSubject("Denúncia -  \(subject)")
            mail.setMessageBody(mailContent, isHTML: true)
            present(mail, animated: true)
        } else {
            // show failure alert
        }
        dao.addOrderedReport(denuncia: dao.denuncia)
        self.performSegue(withIdentifier: "resumotb", sender: self)
        
      //  dao.addOrderedReport(denuncia: dao.denuncia)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
            break
        case MFMailComposeResult.saved:
            print("Mail saved")
            break
        case MFMailComposeResult.sent:
            print("Mail sent")
            isFirstLoad = true
//            dao.addOrderedReport(denuncia: dao.denuncia)
//            self.performSegue(withIdentifier: "resumotb", sender: self)
            break
        case MFMailComposeResult.failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
            break
        }
//        dao.addOrderedReport(denuncia: dao.denuncia)
//        self.performSegue(withIdentifier: "resumotb", sender: self)
        
        controller.dismiss(animated: true)
    }
    
    @IBAction func reportMail(_ sender: Any) {
       //dao.addOrderedReport(denuncia: dao.denuncia)
        sendEmail()
        mainButton.isUserInteractionEnabled = false
        backButton.isUserInteractionEnabled = false
        backButton.backgroundColor = UIColor(named: "water")
        backButton.alpha = 0
        mainButton.alpha = 0
        
        
    }
    
    @IBOutlet weak var descReview: UITextView!
    @IBOutlet weak var check: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Animations
        
        animateButton(sender: mainButton)
       
        check.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.check.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        
        
        
        
        //---------------------------------
        
        mainButton.setTitle("Enviar", for: .normal)
        mainButton.alpha = 1
        mainButton.isUserInteractionEnabled = true
        backButton.isUserInteractionEnabled = false
        backButton.alpha = 0
        
        obsLabel.delegate = self
        obsLabel.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5)
        
        denunciaView.layer.cornerRadius = 10
        
        descReview.text = dao.denuncia.obsUsuario
        tipoDenunciaLabel.text = dao.denuncia.tipoDenuncia
        locationLabel.text = dao.denuncia.address
        obsLabel.text = dao.denuncia.obsUsuario
        
        /*
        
        check.layer.shadowColor = UIColor.black.cgColor
        check.layer.shadowRadius = 1
        check.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        check.layer.shadowOpacity = 0.5
 
        */
 
        descReview.layer.cornerRadius = 5
        
        
        
        
        if tipoDenunciaLabel.text == "Conexão Ilegal" {
            
            denunciaView.backgroundColor = UIColor(named: "water")
             imageIcon.image = UIImage(named: "cancel")
        } else if tipoDenunciaLabel.text == "Vazamento" {
            
            denunciaView.backgroundColor = UIColor(named: "green")
            imageIcon.image = UIImage(named: "drop")
        } else if tipoDenunciaLabel.text == "Falta d'Água" {
            
            denunciaView.backgroundColor = UIColor(named: "purple")
            imageIcon.image = UIImage(named: "ink")
        } else {
            
            denunciaView.backgroundColor = UIColor(named: "redish")
            imageIcon.image = UIImage(named: "question")
        }
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func goToHomePage() {
        
        let tipoDenunciaView: FirstNavController = self.storyboard?.instantiateViewController(withIdentifier: "FirstNavController2") as! FirstNavController
        
        self.navigationController?.present(tipoDenunciaView, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func shareButton(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() as Any
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
        
        
    }
    
    func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.8),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        
        
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

