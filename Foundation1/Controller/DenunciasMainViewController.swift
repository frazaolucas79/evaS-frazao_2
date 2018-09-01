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
    
    //var datas = ["18/06", "21/05","12/05", "12/05","12/05","12/05"]
    
    
    var qntDiasLabel = ["12 dias", "20 dias", "30 dias","30 dias","30 dias","30 dias"]
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dao.denuncias.count == 0 {
            self.tableView.center = self.view.center
            self.tableView.center.y -= 0
            self.tableView.setEmptyMessage("Para criar uma nova denúncia, toque no \"+\" acima.")
        } else {
            self.tableView.restore()
            self.tableView.separatorStyle = .none
        }
        
        return dao.denuncias.count
    }
    
    
    

    @IBAction func closeReport(_ sender: Any) {
        
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at:buttonPosition)
        let _cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! DenunciaCreatedTableViewCell
        print(indexPath![1])
        dao.closeReport(indexPath: indexPath)
        dao.denuncias[indexPath![1]].status = "Fechado"
        dao.save(denuncias: dao.denuncias, in: "Denuncias")
        //self.view.setNeedsDisplay()

        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! DenunciaCreatedTableViewCell
        //print("oi")
        
        /*
        DispatchQueue.main.async() {
            tableView.reloadData()
        }
        */
        
        
        cell.data.text = dao.denuncias[indexPath.row].dateString
        cell.tipoDenuncia.text = dao.denuncias[indexPath.row].tipoDenuncia
       
        print(cell.tipoDenuncia)
        cell.qntDias.text = String(dao.denuncias[indexPath.row].duracaoDenuncia) + " dias"
        cell.status.text = dao.denuncias[indexPath.row].status
        cell.address.text = dao.denuncias[indexPath.row].address
        
        if dao.denuncias[indexPath.row].status == "Fechado" {
        
        //cell.confirm.setTitle("Desfazer Denúncia", for: .normal)
        
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectItemAt indexPath: IndexPath)->Int {
        /*
        let tipoDenunciaView: MapViewController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        print(nomes[indexPath.row])
        dao.getNewDenuncia()
        dao.denuncia.tipoDenuncia = nomes[indexPath.row]
        self.navigationController?.pushViewController(tipoDenunciaView, animated: true)
        */
        
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
        tableView.reloadData()
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
        self.separatorStyle = .singleLine
    }
}




