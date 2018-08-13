//
//  DenunciaCollectionViewCell.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/7/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class DenunciaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var denunciaButton: UIButton!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var imgButton: UIImageView!
    @IBOutlet weak var desc: UITextView!
    


override func awakeFromNib() {
    super.awakeFromNib()
    
    denunciaButton.layer.shadowColor = UIColor.black.cgColor
    denunciaButton.layer.shadowRadius = 5
    denunciaButton.layer.shadowOffset = CGSize(width: 1.0, height: 5.0)
    denunciaButton.layer.shadowOpacity = 0.4
    
    
    
    
    // Initialization code
}
    
    
   
    
    
    

}
