//
//  OverviewTVCon.swift
//  Foundation1
//
//  Created by Lucas Nascimento on 11/08/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class OverviewTVCon: UITableViewController {
    var indexPathRow: Int = -1
    var cell: OverviewTableCell! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.indexPathRow = indexPath.row
        cell = tableView.dequeueReusableCell(withIdentifier: "Overview", for: indexPath) as! OverviewTableCell
        
        
        animateButton(sender: cell.alteraStatusB)
        
        cell.tipoDenuncia.text = dao.denuncias[indexPath.row].tipoDenuncia
        cell.endereco.text = dao.denuncias[indexPath.row].address
        cell.status.text = dao.denuncias[indexPath.row].status
        cell.data.text = dao.denuncias[indexPath.row].dateString
        cell.obsUsuario.text = dao.denuncias[indexPath.row].obsUsuario
        let days = DateUtils.durationDate(date: dao.denuncias[indexPath.row].date, closeDate: dao.denuncias[indexPath.row].closeDate)
        cell.duracaoDenuncia.text = days == 1 ? String(days) + " dia" : String(days) + " dias"
        verifyStatusAndSetButton()
        
        // Configure the cell...

        return cell
    }
    
    func verifyStatusAndSetButton () {
        if (cell.status.text == "Fechado") {
            cell.alteraStatusB.backgroundColor = UIColor(named: "redish")
            cell.alteraStatusQuestion.text = "O problema persiste?"
            cell.alteraStatusB.setTitle("Reabrir Denúncia", for: .normal)
        } else {
            cell.alteraStatusQuestion.text = "O problema foi resolvido?"
            cell.alteraStatusB.backgroundColor = UIColor(named: "water")
            cell.alteraStatusB.setTitle("Fechar Denúncia", for: .normal)
        }
    }
    
    @IBAction func alteraStatusButton(_ sender: UIButton) {
        if (cell.status.text == "Fechado") {
            cell.alteraStatusQuestion.text = "O problema foi resolvido?"
            dao.denuncias[indexPathRow].status = "Aberto"
            cell.status.text = "Aberto"
            cell.alteraStatusB.backgroundColor = UIColor(named: "water")
            cell.alteraStatusB.setTitle("Fechar Denúncia", for: .normal)
        } else {
            cell.alteraStatusQuestion.text = "O problema persiste?"
            dao.denuncias[indexPathRow].status = "Fechado"
            cell.status.text = "Fechado"
            cell.alteraStatusB.backgroundColor = UIColor(named: "redish")
            cell.alteraStatusB.setTitle("Reabrir Denúncia", for: .normal)
        }
        dao.save(denuncias: dao.denuncias, in: "Denuncias")
    }
    
    
    
    
    
    func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(translationX: 0, y: 250)
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            sender.transform = CGAffineTransform(translationX: 0, y: 0 )
        }, completion: nil)
        
        
        
        
    }
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
