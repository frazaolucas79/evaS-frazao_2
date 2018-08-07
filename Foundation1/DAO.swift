//
//  DAO.swift
//  Foundation1
//
//  Created by Foundation_38 on 6/12/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import Foundation

var dao:DAO { return DAO.instance}

class DAO{
    static let instance = DAO()
    var denuncias:[Denuncia] = []
    var denuncia: Denuncia!
    
    func getDenuncias() -> [Denuncia]{
        return denuncias
    }
    
    func getLastDenuncia() -> Denuncia{
        return denuncias.last!
    }
    func getNewDenuncia()-> Denuncia{
        denuncia = Denuncia(address: "", tipoDenuncia: "Mal uso", foto: "", nome: "")
        return denuncia
    }
}

