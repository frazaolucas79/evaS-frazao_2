//
//  DenunciaOptionsViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/7/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class DenunciaOptionsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var nomes = ["Conexão Ilegal","Vazamento","Falta d'Água","Outro"]
    
    var colors = ["water", "green", "purple", "redish"]
    
    var images = ["cancel", "drop", "ink", "question"]
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nomes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath as IndexPath) as! DenunciaCollectionViewCell
        
        
        cell.denunciaButton.isUserInteractionEnabled = false
        
        cell.titulo.text = nomes[indexPath.row]
        
        cell.imgButton.image = UIImage(named: images[indexPath.row])
        
        
        cell.denunciaButton.backgroundColor = UIColor(named: colors[indexPath.row])
        
        cell.desc.isUserInteractionEnabled = false
        
        
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 394)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = layout
        
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        heightConstraint.constant = height
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tipoDenunciaView: MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        // tipoDenuncia.mainLabel = nomes[indexPath.row]
        // tipoDenuncia.colorDenun = colors[indexPath.row]
        print(nomes[indexPath.row])
        dao.getNewDenuncia()
        dao.denuncia.tipoDenuncia = nomes[indexPath.row]
        self.navigationController?.pushViewController(tipoDenunciaView, animated: true)
        
        let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            // Prepare shortly before playing
        lightImpactFeedbackGenerator.prepare()
            
            // Play the haptic signal
        lightImpactFeedbackGenerator.impactOccurred()
            
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        self.pageControl.currentPage = indexPath.row
   
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        
       // cell.alpha = 0
       
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.9),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                       cell.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        
        
        /*
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
        */
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? DenunciaCollectionViewCell {
                cell.imgButton.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = .clear
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? DenunciaCollectionViewCell {
                cell.imgButton.transform = .identity
                cell.contentView.backgroundColor = .clear
            }
        }
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
    
    
    
    /*
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
     switch (segue.destination, sender) {
     case (let controller as MapViewController, let indexPath as NSIndexPath):
     controller.mainLabel = nomes[indexPath.row] //as String
     default:
     print("unknown segue")
     break
     }
     }
     
     */
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
