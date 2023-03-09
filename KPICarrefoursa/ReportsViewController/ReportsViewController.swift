//
//  ReportsViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 9.03.2023.
//

import UIKit
import WebKit


class ReportsViewController: UIViewController {
    
    //    MARK: - Properties

    
    
    //    MARK: - Views
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlComponents = NSURLComponents(string: "http://10.77.170.131/reports/powerbi/Franchise%20Portal/FrPortMobile/DepartmanBazliSatisMobile")
        //        "https://10.77.170.131/reports/powerbi/Franchise%20Portal/FrPortMobile/MalzemeStokHareketleriMobile"
        urlComponents?.user = "mert.yildiz@carrefoursa.com"
        urlComponents?.password = "BilmSoft2208"
        let url = urlComponents?.url
        let requestObj = NSURLRequest(url: url!)
        
        self.webView.load(requestObj as URLRequest)
        
    }
}




