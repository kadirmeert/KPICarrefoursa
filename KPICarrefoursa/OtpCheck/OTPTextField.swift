//
//  OTPTextField.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.11.2022.
//

import Foundation
import UIKit

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    weak var textField: OTPTextField?
    
    override public func deleteBackward(){
        if text == "" {
            previousTextField?.text = ""
            previousTextField?.becomeFirstResponder()
        } else {
            text = ""
        }
        
    }
    
}


