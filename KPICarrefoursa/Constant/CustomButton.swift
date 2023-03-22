//
//  CustomButton.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.03.2023.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable var autoLocalization: Bool = true
    var localizableText:String?
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        if autoLocalization == true && currentTitle != nil {
            localizableText = self.currentTitle
            super.setTitle(localizableText?.localized, for: UIControl.State())
        }
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        if autoLocalization == true && title != nil {
            super.setTitle(title?.localized, for: state)
        }else {
            super.setTitle(title, for: state)
        }
    }

    
}
