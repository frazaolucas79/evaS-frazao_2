//
//  DateUtils.swift
//  Foundation1
//
//  This file must contain all utilities functions and structures that are related do Date and Time.
//  The purpose of this file is to make very common methods / objects available for every class in the
//  application, so that we don't have to duplicate lines of code.
//
//  Created by Bruno Marinho on 11/08/18.
//  Copyright © 2018 Foundation_28. All rights reserved.
//

import UIKit

final class DateUtils {
    private init () {
        
    }
    
    static func durationDate(date: Date, closeDate: Date!)-> Int{
        var day = 0;
        if (closeDate == nil){
            day = -Int(date.timeIntervalSinceNow / 86400)
        } else {
            day = -Int(date.timeIntervalSince(closeDate!) / 86400)
        }
        return day;
    }
}
