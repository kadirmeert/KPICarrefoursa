//
//  SplashViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 13.10.2022.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "sendAuth", sender: self)
   
    }

}
