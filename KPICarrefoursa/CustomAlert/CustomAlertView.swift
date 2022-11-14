//
//  CustomAlertView.swift
//  KPICarrefoursa
//
//  Created by Mert on 31.10.2022.
//

import UIKit

class CustomAlertView: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var alertButtonView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.alertView.dropShadow(cornerRadius: 12)
        self.alertButtonView.dropShadow(cornerRadius: self.alertButtonView.frame.height / 2)
        self.addAnimation()
        self.alertButton.layer.cornerRadius = self.alertButton.frame.height / 2
        
    }
    
    @IBAction func closePopup(_ sender: Any) {
        removeAnimation()
    }

    func addAnimation()  {
        self.mainView.transform = CGAffineTransform(translationX: 0, y: self.mainView.frame.height)
        UIView.animate(withDuration: 0.5, animations: {
            self.mainView.transform = .identity
        })
    }
    
    private func removeAnimation(){
        self.mainView.transform = .identity
        UIView.animate(withDuration: 0.5, animations: {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: self.mainView.frame.height)
        }) { (complete) in
            self.view.removeFromSuperview()
        }
    }
}
