//
//  Denuncia.swift
//  Foundation1
//
//  Created by Foundation_38 on 6/12/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import Foundation
import UIKit
public struct Denuncia: Codable {
    var address:String = ""
    var tipoDenuncia: String = ""
    var fotoData: Data?
    var nome: String! = ""
    var obsUsuario: String = ""
    var status: String = ""
    var dateString: String = ""
    var date: Date
}




extension Data {
    var uiImage:UIImage? {
        return UIImage(data: self)
    }
}

extension UIImage {
    var data:Data? {
        return UIImageJPEGRepresentation(self, 0.7)
    }
}
