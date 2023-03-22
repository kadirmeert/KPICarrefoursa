//
//  ReportsViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 9.03.2023.
//

import UIKit
import WebKit


class ReportsViewController: UIViewController {
    
    
    @IBOutlet weak var reportsWebView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        let urlComponents = NSURLComponents(string: "http://10.77.170.131/reports/powerbi/Franchise%20Portal/FrPortMobile/Ma%C4%9Faza%20Kokpit")
        //        "https://10.77.170.131/reports/powerbi/Franchise%20Portal/FrPortMobile/MalzemeStokHareketleriMobile"
        urlComponents?.user = User.username
        urlComponents?.password = User.password
        let url = urlComponents?.url
        let requestObj = NSURLRequest(url: url!)
        
        self.reportsWebView.load(requestObj as URLRequest)
        
    }
    
}
