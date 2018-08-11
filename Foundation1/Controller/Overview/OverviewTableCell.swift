//
//  OverviewTableCell.swift
//  Foundation1
//
//  Created by Lucas Nascimento on 11/08/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class OverviewTableCell: UITableViewCell {
   
    // Variáveis
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var tipoDenuncia: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var obsUsuario: UITextView!
    @IBOutlet weak var duracaoDenuncia: UILabel!
    @IBOutlet weak var alteraStatusQuestion: UILabel!

    @IBOutlet weak var alteraStatusB: RoundButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        obsUsuario.layer.cornerRadius = 10
        obsUsuario.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
