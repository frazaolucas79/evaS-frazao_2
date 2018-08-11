//
//  DescViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/12/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class DescViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var labelAddress: UILabel!
    
    
    @IBOutlet weak var descText: UITextView!
    
    @IBOutlet weak var addImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelAddress.text! = dao.denuncia.address
        descText.layer.cornerRadius = 10
        descText.layer.borderWidth = 0
        // descText.layer.borderColor = UIColor.white.cgColor
        
        dao.denuncia.obsUsuario = descText.text
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func camera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        dao.denuncia.fotoData = image.data
        addImage.setImage(image, for: UIControlState.normal)
        // print out the image size as a test
        print(image.size)
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
