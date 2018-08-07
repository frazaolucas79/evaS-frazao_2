//
//  ViewController.swift
//  Foundation1
//
//  Created by Foundation_28 on 5/10/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    func presentAfterResponseScreen(){
        let storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let tabBarVc: TabBar=storyboard.instantiateViewController(withIdentifier:"TabBar") as! TabBar
        self.present(tabBarVc, animated: true, completion: nil)
  
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    */
    
    @IBAction func goToNextPage(_ sender: Any) {
    
    //presentAfterResponseScreen()
    
    
    }
    
    
    var itemTable = [Items]()
    
    var tituloTable = ["Quantos litros de agua voce usa no banho?","Quantos pesos de agua voce usa no banho?"]
    
   // var respostaTable = ["","",""]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tituloTable.count
    
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "perguntas", for: indexPath) as? TableViewCell else {
            
            fatalError("Is not available!")
            
        }
        
        cell.titulo.text = tituloTable[indexPath.row]
        
       // cell.resposta.text = respostaTable[indexPath.row]
        
        
        return cell
        
    }
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

