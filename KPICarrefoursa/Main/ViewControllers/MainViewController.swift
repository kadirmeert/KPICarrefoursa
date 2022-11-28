//
//  MainViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import UIKit
import CryptoSwift
import JGProgressHUD
class MainViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    //    @IBOutlet weak var hourlyView: UIView!
    //    @IBOutlet weak var hourlyLabel: UILabel!
    //    @IBOutlet weak var hourlyButton: UIButton!
    @IBOutlet weak var yesterdayView: UIView!
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var yesterdayButton: UIButton!
    @IBOutlet weak var daytodayView: UIView!
    @IBOutlet weak var daytodayLabel: UILabel!
    @IBOutlet weak var daytodayButton: UIButton!
    @IBOutlet weak var weeklyView: UIView!
    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var yeartodateView: UIView!
    @IBOutlet weak var yeartodateLabel: UILabel!
    @IBOutlet weak var yeartodateButton: UIButton!
    @IBOutlet weak var netSalesView: UIView!
    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var customerİmageView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productİmageView: UIView!
    @IBOutlet weak var averageBasketView: UIView!
    @IBOutlet weak var averageBasketİmageView: UIView!
    @IBOutlet weak var averagePriceView: UIView!
    @IBOutlet weak var averagePriceİmageView: UIView!
    @IBOutlet weak var numberOfStoresView: UIView!
    @IBOutlet weak var numberOfStoresİmageView: UIView!
    @IBOutlet weak var homeSwitch: UISwitch!
    @IBOutlet weak var ikibinyirmibirView: UIView!
    @IBOutlet weak var ikibinyirmibirLabel: UILabel!
    @IBOutlet weak var ikibinyirmiikiBView: UIView!
    @IBOutlet weak var ikibinyirmiikiBLabel: UILabel!
    @IBOutlet weak var ikibinyirmiikiLEView: UIView!
    @IBOutlet weak var ikibinyirmiikiLELabel: UILabel!
    @IBOutlet weak var netSalesLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    @IBOutlet weak var averageBasketLabel: UILabel!
    @IBOutlet weak var netSalesPercentageView: UIView!
    @IBOutlet weak var salesİmage: UIImageView!
    @IBOutlet weak var salesPercentageLabel: UILabel!
    @IBOutlet weak var numberOfStoresLabel: UILabel!
    @IBOutlet weak var customerİmage: UIImageView!
    @IBOutlet weak var customerPercentageLabel: UILabel!
    @IBOutlet weak var productİmage: UIImageView!
    @IBOutlet weak var productPercentageLabel: UILabel!
    @IBOutlet weak var basketPercentageLabel: UILabel!
    @IBOutlet weak var basketİmage: UIImageView!
    @IBOutlet weak var pricePercentageLabel: UILabel!
    @IBOutlet weak var priceİmage: UIImageView!
    @IBOutlet weak var sales2021: UIButton!
    @IBOutlet weak var sales2022LE: UIButton!
    @IBOutlet weak var sales2022B: UIButton!
    @IBOutlet weak var scrool: UIScrollView!
    @IBOutlet weak var lastUpdateTime: UILabel!
    @IBOutlet weak var mainLflLabel: UILabel!
    
    //MARK: Properties
    var isMenuSelected = true
    var userDC: String = ""
    var otpCheckViewController = OtpCheckViewController()
    var dashboardValue = DashboardCards()
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    var logoutParams = "{\"Language\": \"tr\",\"ProcessType\": 2}"
    var hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainRadius()
        
        if self.dashboardValue.Customer.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkDataDashboard()
            
        }
        self.refreshControl.tintColor = UIColor.gray
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.scrool.isScrollEnabled = true
        self.scrool.alwaysBounceVertical = true
        scrool.addSubview(refreshControl)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func homeDidValueChanged(_ sender: UISwitch) {
        
        if (sender.isOn == true){
            self.mainLflLabel.text = "LFL"
            //            if hourlyButton.isSelected == true {
            //                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            //            }
            if yesterdayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            }
            if daytodayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1}"
            }
            if weeklyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            }
            if monthlyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            }
            if yeartodateButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1}"
            }
        }
        else{
            self.mainLflLabel.text = "ALL"
            //            if hourlyButton.isSelected == true {
            //                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
            //            }
            if yesterdayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
            }
            if daytodayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0}"
            }
            if weeklyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
            }
            if monthlyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
            }
            if yeartodateButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0}"
            }
        }
        if !self.dashboardValue.Product.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkDataDashboard()
        }
        
        
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        self.checkDataDashboard()
        refreshControl.endRefreshing()
        
    }
    
    
    func mainRadius() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        homeSwitch.set(width: 40, height: 18)
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
        logoutView.layer.cornerRadius = logoutView.frame.height / 2
        //        hourlyView.layer.cornerRadius = 12
        //        hourlyLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        yesterdayView.layer.cornerRadius = 12
        daytodayView.layer.cornerRadius = 12
        weeklyView.layer.cornerRadius = 12
        monthlyView.layer.cornerRadius = 12
        yeartodateView.layer.cornerRadius = 12
        netSalesView.dropShadow(cornerRadius: 12)
        customerView.dropShadow(cornerRadius: 12)
        productView.dropShadow(cornerRadius: 12)
        averageBasketView.dropShadow(cornerRadius: 12)
        averagePriceView.dropShadow(cornerRadius: 12)
        numberOfStoresView.dropShadow(cornerRadius: 12)
        customerİmageView.makeCustomRound(topLeft: 0, topRight: 12, bottomLeft: 64, bottomRight: 0)
        productİmageView.makeCustomRound(topLeft: 0, topRight: 12, bottomLeft: 64, bottomRight: 0)
        averageBasketİmageView.makeCustomRound(topLeft: 0, topRight: 12, bottomLeft: 64, bottomRight: 0)
        averagePriceİmageView.makeCustomRound(topLeft: 0, topRight: 12, bottomLeft: 64, bottomRight: 0)
        numberOfStoresİmageView.makeCustomRound(topLeft: 0, topRight: 12, bottomLeft: 64, bottomRight: 0)
        ikibinyirmibirView.roundCorners(corners: [.topRight, .topLeft], radius: 12)
        ikibinyirmibirView.backgroundColor = .white
        ikibinyirmibirLabel.textColor = UIColor(red:1/255, green:80/255, blue:161/255, alpha: 1)
        yesterdayLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        
        
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    func checkDataDashboard() {
        print(chartParameters)
        let enUrlParams = try! chartParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        print(stringRequest)
        let url = URL(string: DashboardCard)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = stringRequest.data(using: String.Encoding.utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(User.JWT)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
            }
            if let responseString = String(data: data, encoding: .utf8) {
                print("responseString = \(String(describing: responseString))")
                self.userDC = responseString
                self.userDC = try! self.aesDecrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
                print(self.userDC)
                let data: Data? = self.userDC.data(using: .utf8)
                let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:AnyObject]
                print(json ?? "Empty Data")
                if json!["Success"] as? Int ?? 0 ==  0{
                    print("error")
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    self.dashboardValue.NetSales = json!["DashboardCards"]?.value(forKeyPath: "NetSales") as? [String] ?? ["0.0"]
                    self.dashboardValue.AverageBasket = json!["DashboardCards"]?.value(forKey: "AverageBasket") as? [String] ?? ["0.0"]
                    self.dashboardValue.AveragePrice = json!["DashboardCards"]?.value(forKey: "AveragePrice") as? [String] ?? ["0.0"]
                    self.dashboardValue.Customer = json!["DashboardCards"]?.value(forKey: "Customer") as? [String] ?? ["0.0"]
                    self.dashboardValue.Product = json!["DashboardCards"]?.value(forKey: "Product") as? [String] ?? ["0.0"]
                    self.dashboardValue.AverageBasketVs2021 = json!["DashboardCards"]?.value(forKey: "AverageBasketVs2021") as? [String] ?? ["0.0"]
                    self.dashboardValue.AveragePriceVs2021 = json!["DashboardCards"]?.value(forKey: "AveragePriceVs2021") as? [String] ?? ["0.0"]
                    self.dashboardValue.NetSalesvsButceLE = json!["DashboardCards"]?.value(forKey: "NetSalesvsButceLE") as? [String] ?? ["0.0"]
                    self.dashboardValue.Customervs2021 =  json!["DashboardCards"]?.value(forKey: "Customervs2021") as? [String] ?? ["0.0"]
                    self.dashboardValue.NetSalesvs2021 =  json!["DashboardCards"]?.value(forKey: "NetSalesvs2021") as? [String] ?? ["0.0"]
                    self.dashboardValue.NetSalesvs2022B =  json!["DashboardCards"]?.value(forKey: "NetSalesvs2022B") as? [String] ?? ["0.0"]
                    self.dashboardValue.Productvs2021 =  json!["DashboardCards"]?.value(forKey: "Productvs2021") as? [String] ?? ["0.0"]
                    self.dashboardValue.Area =  json!["NumberOfStores"]?.value(forKey: "Area") as? [Int] ?? [0]
                    self.dashboardValue.StoreNumber =  json!["NumberOfStores"]?.value(forKey: "StoreNumber") as? [Int] ?? [0]
                    self.dashboardValue.last_update =  json!["DashboardCards"]?.value(forKey: "last_update") as? [String] ?? [""]
                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        
                        if self.dashboardValue.last_update.isEmpty {
                            self.lastUpdateTime.text = "00/00/0000 00:00:00"
                        } else {
                            self.lastUpdateTime.text = "Last Updated Time \(self.dashboardValue.last_update[0])"
                            
                        }
                       
                        self.numberOfStoresLabel.text = "\(self.dashboardValue.StoreNumber[0]) (\(self.dashboardValue.Area[0] / 1000) km2)"
                        
                        if self.dashboardValue.NetSales.isEmpty {
                            
                            self.netSalesLabel.text = "0.0 MTL"
                            self.salesPercentageLabel.text = "%0.0"
                            
                        } else {
                            
                            if "\(self.dashboardValue.NetSalesvs2021[0].components(separatedBy: ["%"," "]).joined())".toDouble > 0.0 {
                                self.netSalesLabel.text = self.dashboardValue.NetSales[0]
                                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvs2021[0]
                                self.salesİmage.image = UIImage(named: "Up")
                                self.salesPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                
                            }else {
                                self.netSalesLabel.text = self.dashboardValue.NetSales[0]
                                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvs2021[0].components(separatedBy: [" ", "-"]).joined()
                                self.salesİmage.image = UIImage(named: "down")
                                self.salesPercentageLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                            }
                        }
                        
                        if self.dashboardValue.Customervs2021.isEmpty {
                            self.customerLabel.text = "0.0 K"
                            self.customerPercentageLabel.text = "%0.0"
                            
                        } else {
                            
                            if "\(self.dashboardValue.Customervs2021[0].components(separatedBy: ["%"," "]).joined())".toDouble > 0.0 {
                                self.customerLabel.text = self.dashboardValue.Customer[0]
                                self.customerPercentageLabel.text = self.dashboardValue.Customervs2021[0]
                                self.customerİmage.image = UIImage(named: "Up")
                                self.customerİmageView.backgroundColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                self.customerPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                
                            }else {
                                self.customerLabel.text = self.dashboardValue.Customer[0]
                                self.customerPercentageLabel.text = self.dashboardValue.Customervs2021[0].components(separatedBy: [" ", "-"]).joined()
                                self.customerİmage.image = UIImage(named: "down")
                                self.customerPercentageLabel.textColor =  UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                self.customerİmageView.backgroundColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                            }
                        }
                        
                        if self.dashboardValue.Productvs2021.isEmpty {
                            
                            self.productLabel.text = "0.0 K"
                            self.productPercentageLabel.text = "%0.0"
                            
                        } else {
                            
                            if "\(self.dashboardValue.Productvs2021[0].components(separatedBy: ["%"," "]).joined())".toDouble > 0.0 {
                                self.productLabel.text = self.dashboardValue.Product[0]
                                self.productPercentageLabel.text = self.dashboardValue.Productvs2021[0]
                                self.productİmage.image = UIImage(named: "Up")
                                self.productPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                self.productİmageView.backgroundColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                
                            }else {
                                self.productLabel.text = self.dashboardValue.Product[0]
                                self.productPercentageLabel.text = self.dashboardValue.Productvs2021[0].components(separatedBy: [" ", "-"]).joined()
                                self.productİmage.image = UIImage(named: "down")
                                self.productPercentageLabel.textColor =  UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                self.productİmageView.backgroundColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                            }
                        }
                        
                        if self.dashboardValue.AveragePriceVs2021.isEmpty {
                            
                            self.averageBasketLabel.text = "0.0₺"
                            self.basketPercentageLabel.text =  "%0.0"
                            
                        } else {
                            
                            if "\(self.dashboardValue.AverageBasketVs2021[0].components(separatedBy: ["%"," "]).joined())".toDouble > 0.0 {
                                self.averageBasketLabel.text = "\(self.dashboardValue.AverageBasket[0])₺"
                                self.basketPercentageLabel.text = self.dashboardValue.AverageBasketVs2021[0]
                                self.basketİmage.image = UIImage(named: "Up")
                                self.basketPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                self.averageBasketİmageView.backgroundColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                
                            }else {
                                self.averageBasketLabel.text = "\(self.dashboardValue.AverageBasket[0])₺"
                                self.basketİmage.image = UIImage(named: "down")
                                self.basketPercentageLabel.text = self.dashboardValue.AverageBasketVs2021[0].components(separatedBy: [" ", "-"]).joined()
                                self.basketPercentageLabel.textColor =  UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                self.averageBasketİmageView.backgroundColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                            }
                        }
                        
                        if self.dashboardValue.AveragePriceVs2021.isEmpty {
                            
                            self.averagePriceLabel.text = "0.0₺"
                            self.pricePercentageLabel.text = "%0.0"
                            
                        } else {
                            
                            if "\(self.dashboardValue.AveragePriceVs2021[0].components(separatedBy: ["%"," "]).joined())".toDouble > 0.0 {
                                self.averagePriceLabel.text = "\(self.dashboardValue.AveragePrice[0])₺"
                                self.pricePercentageLabel.text = self.dashboardValue.AveragePriceVs2021[0]
                                self.priceİmage.image = UIImage(named: "Up")
                                self.pricePercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                self.averagePriceİmageView.backgroundColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                
                            } else {
                                self.averagePriceLabel.text = "\(self.dashboardValue.AveragePrice[0])₺"
                                self.pricePercentageLabel.text = self.dashboardValue.AveragePriceVs2021[0].components(separatedBy: [" ", "-"]).joined()
                                self.priceİmage.image = UIImage(named: "down")
                                self.pricePercentageLabel.textColor =  UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                self.averagePriceİmageView.backgroundColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                            }
                            
                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func checkLogOut() {
        let enUrlParams = try! logoutParams.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        let url = URL(string: LogOut)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = stringRequest.data(using: String.Encoding.utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(User.JWT)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
            }
            if let responseString = String(data: data, encoding: .utf8) {
                //                print("responseString = \(String(describing: responseString))")
                self.userDC = responseString
                self.userDC = try! self.aesDecrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
                //                print(self.userDC)
                let data: Data? = self.userDC.data(using: .utf8)
                let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:AnyObject]
                print(json ?? "Empty Data")
                if json!["Success"] as? Int ?? 0 ==  0{
                    print("error")
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "isLogin", sender: self)
                    }
                }
            }
        })
        task.resume()
    }
    
    //MARK: Button Pressed
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        self.checkLogOut()
    }
    
    
    //    @IBAction func hourlyBtnPressed(_ sender: Any) {
    //        hourlyButton.isSelected = true
    //        yesterdayButton.isSelected = false
    //        daytodayButton.isSelected = false
    //        weeklyButton.isSelected = false
    //        monthlyButton.isSelected = false
    //        yeartodateButton.isSelected = false
    //        if homeSwitch.isOn == true {
    //            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    //
    //        } else {
    //            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
    //        }
    //        self.checkDataDashboard()
    //        self.hourlyView.backgroundColor = UIColor.white
    //        self.hourlyLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
    //        self.yesterdayView.backgroundColor = UIColor.clear
    //        self.yesterdayLabel.textColor = UIColor.white
    //        self.daytodayView.backgroundColor = UIColor.clear
    //        self.daytodayLabel.textColor = UIColor.white
    //        self.weeklyView.backgroundColor = UIColor.clear
    //        self.weeklyLabel.textColor = UIColor.white
    //        self.monthlyView.backgroundColor = UIColor.clear
    //        self.monthlyLabel.textColor = UIColor.white
    //        self.yeartodateView.backgroundColor = UIColor.clear
    //        self.yeartodateLabel.textColor = UIColor.white
    //    }
    
    @IBAction func yesterdayBtnPressed(_ sender: Any) {
        //        hourlyButton.isSelected = false
        yesterdayButton.isSelected = true
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if homeSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
        }
        self.checkDataDashboard()
        //        self.hourlyView.backgroundColor = UIColor.clear
        //        self.hourlyLabel.textColor = UIColor.white
        self.yesterdayView.backgroundColor = UIColor.white
        self.yesterdayLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.daytodayView.backgroundColor = UIColor.clear
        self.daytodayLabel.textColor = UIColor.white
        self.weeklyView.backgroundColor = UIColor.clear
        self.weeklyLabel.textColor = UIColor.white
        self.monthlyView.backgroundColor = UIColor.clear
        self.monthlyLabel.textColor = UIColor.white
        self.yeartodateView.backgroundColor = UIColor.clear
        self.yeartodateLabel.textColor = UIColor.white
    }
    
    @IBAction func daytodayBtnPressed(_ sender: Any) {
        //        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = true
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if homeSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 0}"
        }
        self.checkDataDashboard()
        //        self.hourlyView.backgroundColor = UIColor.clear
        //        self.hourlyLabel.textColor = UIColor.white
        self.yesterdayView.backgroundColor = UIColor.clear
        self.yesterdayLabel.textColor = UIColor.white
        self.daytodayView.backgroundColor = UIColor.white
        self.daytodayLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.weeklyView.backgroundColor = UIColor.clear
        self.weeklyLabel.textColor = UIColor.white
        self.monthlyView.backgroundColor = UIColor.clear
        self.monthlyLabel.textColor = UIColor.white
        self.yeartodateView.backgroundColor = UIColor.clear
        self.yeartodateLabel.textColor = UIColor.white
    }
    
    @IBAction func weeklyBtnPressed(_ sender: Any) {
        //        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = true
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if homeSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
        }
        self.checkDataDashboard()
        //        self.hourlyView.backgroundColor = UIColor.clear
        //        self.hourlyLabel.textColor = UIColor.white
        self.yesterdayView.backgroundColor = UIColor.clear
        self.yesterdayLabel.textColor = UIColor.white
        self.daytodayView.backgroundColor = UIColor.clear
        self.daytodayLabel.textColor = UIColor.white
        self.weeklyView.backgroundColor = UIColor.white
        self.weeklyLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.monthlyView.backgroundColor = UIColor.clear
        self.monthlyLabel.textColor = UIColor.white
        self.yeartodateView.backgroundColor = UIColor.clear
        self.yeartodateLabel.textColor = UIColor.white
    }
    
    @IBAction func monthlyBtnPressed(_ sender: Any) {
        //        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = true
        yeartodateButton.isSelected = false
        if homeSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
        }
        self.checkDataDashboard()
        //        self.hourlyView.backgroundColor = UIColor.clear
        //        self.hourlyLabel.textColor = UIColor.white
        self.yesterdayView.backgroundColor = UIColor.clear
        self.yesterdayLabel.textColor = UIColor.white
        self.daytodayView.backgroundColor = UIColor.clear
        self.daytodayLabel.textColor = UIColor.white
        self.weeklyView.backgroundColor = UIColor.clear
        self.weeklyLabel.textColor = UIColor.white
        self.monthlyView.backgroundColor = UIColor.white
        self.monthlyLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.yeartodateView.backgroundColor = UIColor.clear
        self.yeartodateLabel.textColor = UIColor.white
    }
    
    @IBAction func yeartodateBtnPressed(_ sender: Any) {
        //        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = true
        if homeSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0}"
        }
        
        self.checkDataDashboard()
        //        self.hourlyView.backgroundColor = UIColor.clear
        //        self.hourlyLabel.textColor = UIColor.white
        self.yesterdayView.backgroundColor = UIColor.clear
        self.yesterdayLabel.textColor = UIColor.white
        self.daytodayView.backgroundColor = UIColor.clear
        self.daytodayLabel.textColor = UIColor.white
        self.weeklyView.backgroundColor = UIColor.clear
        self.weeklyLabel.textColor = UIColor.white
        self.monthlyView.backgroundColor = UIColor.clear
        self.monthlyLabel.textColor = UIColor.white
        self.yeartodateView.backgroundColor = UIColor.white
        self.yeartodateLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        
    }
    @IBAction func netSalesBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendSales", sender: self)
    }
    
    @IBAction func customerBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendCustomer", sender: self)
    }
    
    @IBAction func productBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendProduct", sender: self)
    }
    
    @IBAction func averageBasketBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendBasket", sender: self)
    }
    
    @IBAction func averagePriceBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendPrice", sender: self)
    }
    
    @IBAction func numberOfStoresBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "sendStores", sender: self)
    }
    
    @IBAction func ikibinyirmibirBtnPressed(_ sender: Any) {
        ikibinyirmibirView.roundCorners(corners: [.topRight, .topLeft], radius: 12)
        ikibinyirmibirView.backgroundColor = .white
        ikibinyirmibirLabel.textColor = UIColor(red:1/255, green:80/255, blue:161/255, alpha: 1)
        ikibinyirmiikiBView.backgroundColor = .clear
        ikibinyirmiikiBLabel.textColor = .white
        ikibinyirmiikiLEView.backgroundColor = .clear
        ikibinyirmiikiLELabel.textColor = .white
        
        if dashboardValue.NetSalesvs2021.isEmpty {
            
            self.salesPercentageLabel.text = "%0.0"
            
        } else {
            
            if "\(dashboardValue.NetSalesvs2021[0].components(separatedBy: ["%"," "]).joined())".toDouble >= 0.0 {
                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvs2021[0]
                self.salesİmage.image = UIImage(named: "Up")
                self.salesPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                
            } else {
                
                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvs2021[0].components(separatedBy: [" ", "-"]).joined()
                self.salesİmage.image = UIImage(named: "down")
                self.salesPercentageLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
            }
        }
    }
    
    @IBAction func ikibinyirmiikiBBtnPressed(_ sender: Any) {
        ikibinyirmiikiBView.roundCorners(corners: [.topRight, .topLeft], radius: 12)
        ikibinyirmiikiBView.backgroundColor = .white
        ikibinyirmiikiBLabel.textColor = UIColor(red:1/255, green:80/255, blue:161/255, alpha: 1)
        ikibinyirmibirView.backgroundColor = .clear
        ikibinyirmibirLabel.textColor = .white
        ikibinyirmiikiLEView.backgroundColor = .clear
        ikibinyirmiikiLELabel.textColor = .white
        
        if dashboardValue.NetSalesvs2022B.isEmpty {
            self.salesPercentageLabel.text =  "%0.0"

        } else {
            
            if "\(dashboardValue.NetSalesvs2022B[0].components(separatedBy: ["%"," "]).joined())".toDouble >= 0.0 {
                self.salesPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvs2022B[0]
                self.salesİmage.image = UIImage(named: "Up")
            } else {
                self.salesPercentageLabel.text =  self.dashboardValue.NetSalesvs2022B[0].components(separatedBy: [" ", "-"]).joined()
                self.salesİmage.image = UIImage(named: "down")
                self.salesPercentageLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
            }
        }
    }
    
    @IBAction func ikibinyirmiikiLEBtnPressed(_ sender: Any) {
        ikibinyirmiikiLEView.roundCorners(corners: [.topRight, .topLeft], radius: 12)
        ikibinyirmiikiLEView.backgroundColor = .white
        ikibinyirmiikiLELabel.textColor = UIColor(red:1/255, green:80/255, blue:161/255, alpha: 1)
        ikibinyirmibirView.backgroundColor = .clear
        ikibinyirmibirLabel.textColor = .white
        ikibinyirmiikiBView.backgroundColor = .clear
        ikibinyirmiikiBLabel.textColor = .white
        
        if dashboardValue.NetSalesvsButceLE.isEmpty {
            self.salesPercentageLabel.text = "%0.0"

        } else {
            
            if "\(dashboardValue.NetSalesvsButceLE[0].components(separatedBy: ["%"," "]).joined())".toDouble >= 0.0 {
                self.salesPercentageLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvsButceLE[0]
                self.salesİmage.image = UIImage(named: "Up")
            } else {
                self.salesPercentageLabel.text = self.dashboardValue.NetSalesvsButceLE[0].components(separatedBy: ["-"]).joined()
                self.salesİmage.image = UIImage(named: "down")
                self.salesPercentageLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
            }
        }
    }
}



