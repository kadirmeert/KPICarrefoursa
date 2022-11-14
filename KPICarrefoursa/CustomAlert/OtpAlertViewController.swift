//
//  OtpAlertViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.11.2022.
//

import UIKit

class OtpAlertViewController: UIViewController {

    @IBOutlet var otpMainView: UIView!
    @IBOutlet weak var otpAlertView: UIView!
    @IBOutlet weak var otpAlertButton: UIButton!
    @IBOutlet weak var otpAlertButtonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.otpAlertView.dropShadow(cornerRadius: 12)
        self.otpAlertButtonView.dropShadow(cornerRadius: self.otpAlertButtonView.frame.height / 2)
        self.addAnimation()
        self.otpAlertButton.layer.cornerRadius = self.otpAlertButton.frame.height / 2
        
    }
    
    @IBAction func closePopup(_ sender: Any) {
        removeAnimation()
    }

    func addAnimation()  {
        self.otpMainView.transform = CGAffineTransform(translationX: 0, y: self.otpMainView.frame.height)
        UIView.animate(withDuration: 0.5, animations: {
            self.otpMainView.transform = .identity
        })
    }
    
    private func removeAnimation(){
        self.otpMainView.transform = .identity
        UIView.animate(withDuration: 0.5, animations: {
            self.otpMainView.transform = CGAffineTransform(translationX: 0, y: self.otpMainView.frame.height)
        }) { (complete) in
            self.view.removeFromSuperview()
        }
    }
}
