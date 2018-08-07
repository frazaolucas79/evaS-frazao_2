//
//  PerfilVC.swift
//  Foundation1
//
//  Created by Foundation_28 on 5/17/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class PerfilVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var imgProfile: UIImageView!

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagens = ["user","idea"]
    
    var colors = ["water", "purple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
       // imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
       // imgProfile.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PerfilCollectionCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let image = UIImage(named: imagens[indexPath.row])
        
        cell.img.image = image
        
        let color = UIColor(named: colors[indexPath.row])
        
        cell.button.backgroundColor = color
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        
        
        print("You selected cell #\(indexPath.item)!")
        
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cell", for: indexPath) as? PerfilTitleSection{
            sectionHeader.titleSection.text = "Minhas Denúncias"
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
