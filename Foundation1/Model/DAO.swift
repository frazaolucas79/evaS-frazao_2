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
    
    func orderArrayByDate(denuncias: [Denuncia]) -> [Denuncia]{
        return denuncias.sorted(by: sortByDate)
    }
    
    func sortByDate(this: Denuncia, that: Denuncia) -> Bool {
        return (this.date > that.date)
    }
    
    func addOrderedReport(denuncia: Denuncia) {
        self.denuncias.append(denuncia)
        self.denuncias = orderArrayByDate(denuncias: denuncias)
    }
    // fecha denuncia e calcula duracao
    func closeReport(indexPath: IndexPath?) {
        let userCalendar = Calendar.current
        
        dao.denuncias[indexPath![1]].status = "Fechado"
        dao.denuncias[indexPath![1]].closeDate = Date()
        dao.denuncias[indexPath![1]].duracaoDenuncia = Int(userCalendar.dateComponents([.day],
                                                                                   from: dao.denuncias[indexPath![1]].date,
                                                                                   to: dao.denuncias[indexPath![1]].closeDate!).day!)
    }
    
    //Salva a Classe Atividades
    func save(denuncias: [Denuncia], in file:String) {
        let url = getURLInDocumentDir(for: file)
        let denunciasOrdered = orderArrayByDate(denuncias: denuncias)
        do {
            try JSONEncoder().encode(denunciasOrdered).write(to: url)
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
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        let result = formatter.string(from: date)
        denuncia = Denuncia(address: "", tipoDenuncia: "", fotoData: nil, nome: "", obsUsuario: "", status: "Em aberto", dateString: result, date: date, closeDate: nil, duracaoDenuncia: 1)
        return denuncia
    }
}
