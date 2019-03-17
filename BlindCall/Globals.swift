//
//  Globals.swift
//  BlindCall
//
//  Created by Nadith Dharmasena on 3/16/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class Globals {
    
    static let screenDimen = UIScreen.main.bounds
    static let serverURL = "http://localhost:3000"
    
    static func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
}
