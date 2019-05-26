//
//  Numeric.swift
//  PlatziFinanzas
//
//  Created by Manuel Alejandro Aguilar Tellez Giron on 5/6/19.
//  Copyright © 2019 Manuel Alejandro Aguilar Tellez Giron. All rights reserved.
//

import UIKit

extension Numeric {
    
    func currency() -> String {
        var formatter = NumberFormatter()
        
        //Para poder usar la moneda local
        formatter.locale = Locale.current
        
        formatter.numberStyle = .currency
        
        guard let formatted = formatter.string(from: self as! NSNumber) else {
            return "\(self)"
        }
        
        return formatted
    }
    
}
