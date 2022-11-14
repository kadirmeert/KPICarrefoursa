//
//  OTPConfirmTextField.swift
//  KPICarrefoursa
//
//  Created by Mert on 7.11.2022.
//

import Foundation
import UIKit

class OTPConfirmTextField: UITextField {
    
    weak var previousTextField: OTPConfirmTextField?
    weak var nextTextField: OTPConfirmTextField?
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
        previousTextField?.text = ""
    }
    
}
