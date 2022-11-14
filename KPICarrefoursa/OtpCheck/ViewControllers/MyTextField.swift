//
//  MyTextField.swift
//  KPICarrefoursa
//
//  Created by Mert on 4.11.2022.
//

import UIKit

protocol MyTextFieldDelegate: AnyObject {
    func textFieldDidDelete()
}

class MyTextField: UITextField {

    weak var myDelegate: MyTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }

}
