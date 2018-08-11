//
//  DenunciasMainViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 6/18/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class DenunciasMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var rowConfirm: Int = 0
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dao.denuncias.count == 0 {
            //self.tableView.center = self.view.center
            //self.tableView.center.y -= 200
            self.tableView.setEmptyMessage("Para criar uma nova denúncia, toque no \"+\" acima.")
        }
            else {
            
                self.tableView.restore()
        }
        
        return dao.denuncias.count
    }
 

    @IBAction func closeReport(_ sender: Any) {
        
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at:buttonPosition)
        //let _cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! DenunciaCreatedTableViewCell
        //print(indexPath![1])
        dao.closeReport(indexPath: indexPath)
        //dao.denuncias[indexPath![1]].status = "Fechado"
        dao.save(denuncias: dao.denuncias, in: "Denuncias")
        _cell.status.textColor = UIColor(named: "redish")
        //_cell.heightConsButton.constant = 200
        //self.view.setNeedsDisplay()

        self.tableView.reloadData()
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! DenunciaCreatedTableViewCell
        //print("oi")
        
        cell.data.text = dao.denuncias[indexPath.row].dateString
        cell.tipoDenuncia.text = dao.denuncias[indexPath.row].tipoDenuncia

        print(cell.tipoDenuncia)
        
        let days = durationDate(date: dao.denuncias[indexPath.row].date, row: indexPath.row)
        cell.qntDias.text = days == 1 ? String(days) + " dia" : String(days) + " dias"
        cell.status.text = dao.denuncias[indexPath.row].status
        cell.address.text = dao.denuncias[indexPath.row].address
        
        if dao.denuncias[indexPath.row].status == "Fechado" {
        
            cell.confirm.setTitle("Reabrir Denúncia", for: .normal)
        
        } else {
            cell.confirm.setTitle("Fechar Denúncia", for: .normal)
        }
        return cell
        
    }
   
    
    func durationDate( date: Date, row: Int)-> Int{
        var day = 0;
        if (dao.denuncias[row].closeDate == nil){
            day = -Int(date.timeIntervalSinceNow / 3600)
        } else {
            day = -Int(date.timeIntervalSince(dao.denuncias[row].closeDate!) / 3600)
        }
        return day;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectItemAt indexPath: IndexPath)->Int {
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! DenunciaCreatedTableViewCell
        
      //  let tipoDenunciaView: DenunciaOverViewVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! DenunciaOverViewVC
        
        //let collectionView: OverviewDenunciaCell = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! OverviewDenunciaCell
        
       // collectionView.tipoDenúncia.text = dao.denuncias[indexPath.row].tipoDenuncia

        dao.getNewDenuncia()
   
        //self.navigationController?.pushViewController(tipoDenunciaView, animated: true)
        
        
        return indexPath.row
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // tableView.alwaysBounceVertical = true
        
        tableView.isScrollEnabled = true
        dao.denuncias = dao.getDenuncias(from: "Denuncias")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //tableView.reloadData()
         animateTable()
        
    }
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // Animações
    
    /*
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
    
        UITableView.animate(
            withDuration: 0.3,
            animations: {
                
                cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    
    
    }
    */
    
    
    func animateTable() {
       self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            self.tableView.isHidden = false
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.0, delay: 0.04 * Double(index), usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }

    
    //------------------------------------
    
    
}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        messageLabel.sizeToFit()
      
        
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}




