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
    
    // Diretório Documentos padrão do Sistema
    static let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    
    // gera uma URL para o arquivo em documentDir
    func getURLInDocumentDir(for file:String)->URL {
        return URL(fileURLWithPath: DAO.documentDir.appendingPathComponent(file+".json"))
    }
    
    //Salva a Classe Atividades
    func save(denuncias: [Denuncia], in file:String) {
        let url = getURLInDocumentDir(for: file)
        do {
            try JSONEncoder().encode(denuncias).write(to: url)
            print("Salvo em", String(describing: url))
        } catch {
            print("Não foi possível salvar em", String(describing: url))
        }
    }
    
    // Pega as atividades salvas, ou default
    func getDenuncias(from file:String)->[Denuncia] {
        let url = getURLInDocumentDir(for: file)
        do {
            let readedData = try Data(contentsOf: url)
            let denuncias = try JSONDecoder().decode([Denuncia].self, from: readedData)
            return denuncias
        } catch {
            print("Não foi possível ler de", String(describing: url))
        }
        return []
    }
    
    func getDenuncias() -> [Denuncia]{
        return denuncias
    }
    
    func getLastDenuncia() -> Denuncia{
        return denuncias.last!
    }
    func getNewDenuncia()-> Denuncia{
        denuncia = Denuncia(address: "", tipoDenuncia: "", fotoData: nil, nome: "", obsUsuario: "", status: "Em aberto")
        return denuncia
    }
}
