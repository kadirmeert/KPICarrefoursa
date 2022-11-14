//
//  BackspaceTextField.swift
//  KPICarrefoursa
//
//  Created by Mert on 4.11.2022.
//

import UIKit

class BackspaceTextField: UITextField {
    weak var backspaceTextFieldDelegate: BackspaceTextFieldDelegate?

    override func deleteBackward() {
        if text?.isEmpty ?? false {
            backspaceTextFieldDelegate?.textFieldDidEnterBackspace(self)
        }

        super.deleteBackward()
    }
}

protocol BackspaceTextFieldDelegate: class {
    func textFieldDidEnterBackspace(_ textField: BackspaceTextField)
}
