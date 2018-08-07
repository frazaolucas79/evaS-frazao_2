//
//  TableViewCell.swift
//  Foundation1
//
//  Created by Foundation_28 on 5/10/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var resposta: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
       resposta.text = ""
        
        
    
    
    
    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
