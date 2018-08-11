//
//  DenunciaCreatedTableViewCell.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/18/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class DenunciaCreatedTableViewCell: UITableViewCell {
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var tipoDenuncia: UILabel!
    @IBOutlet weak var qntDias: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var heightConsButton: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowRadius = 5
        buttonView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        buttonView.layer.shadowOpacity = 0.5
    
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
