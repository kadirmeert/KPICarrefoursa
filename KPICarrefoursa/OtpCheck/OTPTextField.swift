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
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
        previousTextField?.text = ""
    }
    
}


