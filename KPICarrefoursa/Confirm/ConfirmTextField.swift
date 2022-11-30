//
//  ConfirmTextField.swift
//  KPICarrefoursa
//
//  Created by Mert on 7.11.2022.
//

import Foundation
import UIKit

class ConfirmTextField: UITextField {
    
    weak var previousTextField: ConfirmTextField?
    weak var nextTextField: ConfirmTextField?
    
    override public func deleteBackward(){
        if text == "" {
            previousTextField?.text = ""
            previousTextField?.becomeFirstResponder()
        } else {
            text = ""
        }
    }
}
