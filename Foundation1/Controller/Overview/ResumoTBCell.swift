//
//  ResumoTBCell.swift
//  
//
//  Created by Lucas Nascimento on 11/08/18.
//

import UIKit

class ResumoTBCell: UITableViewCell {

    @IBOutlet weak var goBack: UIButton!
    
    
    func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(translationX: 0, y: 750)
        
        
        /*
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.4),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        */
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
            sender.transform = CGAffineTransform(translationX: 0, y: 0);
        }, completion: nil)
        
 
 
 
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        animateButton(sender: goBack)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
