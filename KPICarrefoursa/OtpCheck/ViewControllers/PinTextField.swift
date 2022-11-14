//
//  PinTextField.swift
//  KPICarrefoursa
//
//  Created by Mert on 4.11.2022.
//

import UIKit

// Extend from PinTextFieldDelegate instead of UITextFieldDelegate in your class
protocol PinTextFieldDelegate : UITextFieldDelegate {
    func didPressBackspace(_ textField: PinTextField)
}

class PinTextField: UITextField {

    override func deleteBackward() {
        super.deleteBackward()

        // If conforming to our extension protocol
        if let pinDelegate = self.delegate as? PinTextFieldDelegate {
            pinDelegate.didPressBackspace(self)
        }
    }
}
