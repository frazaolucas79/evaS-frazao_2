//
//  ReduzirViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 5/11/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class ReduzirViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagens1 = ["um", "dois", "tres", "quatro", "cinco", "seis"]
    var imagens2 = ["idea","sign", "user", "Logo","email", "sabesp"]
    var allSectionsImages:[[String]] = []
    var titulos = ["Desafios", "Dicas", "Denúncias"]

    var colors = ["water", "coal", "purple", "redish", "green"]
    
    var sugestionTable = [Sugestoes]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        allSectionsImages = [imagens1, imagens2, imagens1]
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
   
     func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    // make a cell for each cell index path
    
    /*
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath as IndexPath) as! ReduzirCollectionCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //let image = UIImage(named: allSectionsImages[indexPath.section][indexPath.row])
        
        //cell.img.image = image
        
        let color = UIColor(named: colors[indexPath.row])
        
        //cell.button.backgroundColor = color
        
        return cell
    }
 
 
 */
    // MARK: - UICollectionViewDelegate protocol
   
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
   
    
    }
 */
 
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return titulos.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //    let layout = UICollectionViewFlowLayout()
          //  layout.scrollDirection = .horizontal
            //let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? ReduzirTitleSection{
            sectionHeader.sectionHeaderLabel.text = titulos[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
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
