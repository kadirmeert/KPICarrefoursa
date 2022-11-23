//
//  NetSalesViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 22.10.2022.
//

import UIKit
import Charts
import CryptoSwift
import MKMagneticProgress
import JGProgressHUD

class NetSalesViewController: UIViewController, ChartViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var ciroView: UIView!
    @IBOutlet weak var netSales2021BackView: UIView!
    @IBOutlet weak var netSales2022BBackView: UIView!
    @IBOutlet weak var netSales2022LeBackView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var chanelView: UIView!
    @IBOutlet weak var chanelChartView: PieChartView!
    @IBOutlet weak var chanelTableView: UITableView!
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var storesChartView: PieChartView!
    @IBOutlet weak var storesTableView: UITableView!
    @IBOutlet weak var progress2021: UIProgressView!
    @IBOutlet weak var progress2022B: UIProgressView!
    @IBOutlet weak var progress2022LE: UIProgressView!
    @IBOutlet weak var FormatView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var fmcgProgress: MKMagneticProgress!
    @IBOutlet weak var freshFoodProgress: MKMagneticProgress!
    @IBOutlet weak var homeProgress: MKMagneticProgress!
    @IBOutlet weak var textileProgress: MKMagneticProgress!
    @IBOutlet weak var electronicProgress: MKMagneticProgress!
    @IBOutlet weak var otherProgress: MKMagneticProgress!
    @IBOutlet weak var foodProgress: MKMagneticProgress!
    @IBOutlet weak var nonFoodProgress: MKMagneticProgress!
    @IBOutlet weak var percentage2021: UILabel!
    @IBOutlet weak var MTL2021: UILabel!
    @IBOutlet weak var percentage2022B: UILabel!
    @IBOutlet weak var MTL2022B: UILabel!
    @IBOutlet weak var percentage2022LE: UILabel!
    @IBOutlet weak var MTL2022LE: UILabel!
    @IBOutlet weak var netSales2021View: UIView!
    @IBOutlet weak var netSales2021Label: UILabel!
    @IBOutlet weak var netSales2021Button: UIButton!
    @IBOutlet weak var netSales2022BView: UIView!
    @IBOutlet weak var netSales2022BLabel: UILabel!
    @IBOutlet weak var netSales2022BButton: UIButton!
    @IBOutlet weak var netSales2022LEView: UIView!
    @IBOutlet weak var netSales2022LELabel: UILabel!
    @IBOutlet weak var netSales2022LEButton: UIButton!
//    @IBOutlet weak var hourlyStoreView: UIView!
//    @IBOutlet weak var hourlyStoreLabel: UILabel!
//    @IBOutlet weak var hourlyStoreButton: UIButton!
    @IBOutlet weak var yesterdayStoreView: UIView!
    @IBOutlet weak var yesterdayStoreLabel: UILabel!
    @IBOutlet weak var yesterdayStoreButton: UIButton!
    @IBOutlet weak var daytodayStoreView: UIView!
    @IBOutlet weak var daytodayStoreLabel: UILabel!
    @IBOutlet weak var daytodayStoreButton: UIButton!
    @IBOutlet weak var weeklyStoreView: UIView!
    @IBOutlet weak var weeklyStoreLabel: UILabel!
    @IBOutlet weak var weeklyStoreButton: UIButton!
    @IBOutlet weak var monthlyStoreView: UIView!
    @IBOutlet weak var monthlyStoreLabel: UILabel!
    @IBOutlet weak var monthlyStoreButton: UIButton!
    @IBOutlet weak var yeartodateStoreView: UIView!
    @IBOutlet weak var yeartodateStoreLabel: UILabel!
    @IBOutlet weak var yeartodateStoreButton: UIButton!
    @IBOutlet weak var scrool: UIScrollView!
    @IBOutlet weak var lastUpdateTİme: UILabel!
    @IBOutlet weak var netSalesSwitch: UISwitch!
    @IBOutlet weak var netSalesChanelHeight: NSLayoutConstraint!
    @IBOutlet weak var netSalesStoresHeight: NSLayoutConstraint!
    @IBOutlet weak var netSalesHeight: NSLayoutConstraint!
    @IBOutlet weak var formatTableView: UITableView!
    @IBOutlet weak var netSalesFormatHeight: NSLayoutConstraint!
    @IBOutlet weak var fmcgPercLabel: UILabel!
    @IBOutlet weak var freshFoodPercLabel: UILabel!
    @IBOutlet weak var homePercLabel: UILabel!
    @IBOutlet weak var textfilePercLabel: UILabel!
    @IBOutlet weak var electronicPercLabel: UILabel!
    @IBOutlet weak var otherPercLabel: UILabel!
    @IBOutlet weak var foodPercLabel: UILabel!
    @IBOutlet weak var nonFoodPercLabel: UILabel!
    @IBOutlet weak var fmcgİmage: UIImageView!
    @IBOutlet weak var freshFoodİmage: UIImageView!
    @IBOutlet weak var homeİmage: UIImageView!
    @IBOutlet weak var textfileİmage: UIImageView!
    @IBOutlet weak var electronicİmage: UIImageView!
    @IBOutlet weak var otherİmage: UIImageView!
    @IBOutlet weak var foodİmage: UIImageView!
    @IBOutlet weak var nonFoodİmage: UIImageView!
    @IBOutlet weak var netSalesLflLabel: UILabel!
    @IBOutlet weak var sales2021İmage: UIImageView!
    @IBOutlet weak var sales2022Bİmage: UIImageView!
    @IBOutlet weak var sales2022LEimage: UIImageView!
    
    //MARK: Properties
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
    var Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
    var Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
    var Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
    var netSalesCiro = Ciro()
    var netSalesStores = Stores()
    var netSalesChannel = Channel()
    var netSalesFormat = Format()
    var netSalesCategory = Category()
    var hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    let str: Array = [String]()
    var years = "2021"
    let removeCharacters: Set<Character> = ["v", "s", "%", "K", "T", "L", " ", "B", "E"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        if self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
            self.refreshControl.tintColor = UIColor.gray
            self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
            self.scrool.isScrollEnabled = true
            self.scrool.alwaysBounceVertical = true
            scrool.addSubview(refreshControl)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupPieChart()
    }
    
    @objc func refresh(sender:AnyObject) {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        self.checkNetSales()
        refreshControl.endRefreshing()
        
    }
    
    func prepareUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        storesChartView.delegate = self
        chanelChartView.delegate = self
        yesterdayStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
//        hourlyStoreView.layer.cornerRadius = 12
//        hourlyStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        yesterdayStoreView.layer.cornerRadius = 12
        daytodayStoreView.layer.cornerRadius = 12
        weeklyStoreView.layer.cornerRadius = 12
        monthlyStoreView.layer.cornerRadius = 12
        yeartodateStoreView.layer.cornerRadius = 12
        self.netSales2021View.backgroundColor = UIColor.white
        self.netSales2021Label.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
        self.netSales2021View.dropShadow(cornerRadius: 12)
        self.netSales2022BView.dropShadow(cornerRadius: 12)
        self.netSales2022LEView.dropShadow(cornerRadius: 12)
        self.ciroView.dropShadow(cornerRadius: 12)
        self.chanelView.dropShadow(cornerRadius: 12)
        self.storesView.dropShadow(cornerRadius: 12)
        self.FormatView.dropShadow(cornerRadius: 12)
        self.categoryView.dropShadow(cornerRadius: 12)
        self.chanelChartView.dropShadow(cornerRadius: 12)
        self.netSales2021BackView.dropShadow(cornerRadius: 5)
        self.netSales2022BBackView.dropShadow(cornerRadius: 5)
        self.netSales2022LeBackView.dropShadow(cornerRadius: 5)
        self.totalView.dropShadow(cornerRadius: 5)
        self.progress2021.layer.cornerRadius = 5
        self.progress2022B.layer.cornerRadius = 5
        self.progress2022LE.layer.cornerRadius = 5

    }
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.netSalesLflLabel.text = "LFL"
//            if hourlyStoreButton.isSelected == true {
//                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
//                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
//                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
//                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
//            }
            self.yesterdayStoreButton.isSelected = true
            if yesterdayStoreButton.isSelected == true {
                
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
            }
            if daytodayStoreButton.isSelected == true {
                
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
            }
            if weeklyStoreButton.isSelected == true {
                
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
            }
            if monthlyStoreButton.isSelected == true {
                
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
            }
            if yeartodateStoreButton.isSelected == true {
                
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
            }
        }
        else{
            self.netSalesLflLabel.text = "ALL"
//            if hourlyStoreButton.isSelected == true {
//                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
//                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
//                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
//                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
//            }
            self.yesterdayStoreButton.isSelected = true
            if yesterdayStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
            }
            if daytodayStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
            }
            if weeklyStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
            }
            if monthlyStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
            }
            if yeartodateStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
            }
        }
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
    }
    override func viewWillLayoutSubviews() {
        self.netSalesStoresHeight.constant = self.storesTableView.contentSize.height
        self.netSalesChanelHeight.constant = self.chanelTableView.contentSize.height
        self.netSalesFormatHeight.constant = self.formatTableView.contentSize.height + 10
        if self.netSalesFormat.Format.count >= 6 {
            self.netSalesHeight.constant = 3100
        } else if self.netSalesFormat.Format.count < 4 {
            self.netSalesHeight.constant = 2500
        }
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    func checkNetSales() {
        let enUrlParams = try! chartParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        print(stringRequest)
        let url = URL(string: NetSalesCards)!
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
                    
                    self.netSalesCiro.Ciro = json!["NetSalesTurnover"]?.value(forKey: "Ciro") as? [String] ?? ["0"]
                    self.netSalesCiro.Gelisim = json!["NetSalesTurnover"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    self.netSalesCiro.IsLfl = json!["NetSalesTurnover"]?.value(forKey: "IsLfl") as? [Int] ?? [0]
                    self.netSalesStores.Aciklama = json!["NetSalesByStores"]?.value(forKey: "Aciklama") as? [String] ?? ["0"]
                    self.netSalesStores.Oran = json!["NetSalesByStores"]?.value(forKey: "Oran") as? [Int] ?? [0]
                    self.netSalesStores.ColorStores = json!["NetSalesByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.netSalesStores.Stores = json!["NetSalesByStores"]?.value(forKey: "Stores") as? [String] ?? ["0"]
                    self.netSalesChannel.Aciklama = json!["NetSalesByChannel"]?.value(forKey: "Aciklama") as? [String] ?? ["0"]
                    self.netSalesChannel.Channels = json!["NetSalesByChannel"]?.value(forKey: "Channels") as? [String] ?? ["0"]
                    self.netSalesChannel.ColorChannels = json!["NetSalesByChannel"]?.value(forKey: "ColorChannels") as? [String] ?? ["0"]
                    self.netSalesChannel.IsLfl = json!["NetSalesByChannel"]?.value(forKey: "IsLfl") as? [Int] ?? [0]
                    self.netSalesChannel.Oran = json!["NetSalesByChannel"]?.value(forKey: "Oran") as? [Int] ?? [0]
                    self.netSalesFormat.Aciklama1 = json!["NetSalesByFormat"]?.value(forKey: "Aciklama1") as? [String] ?? ["0"]
                    self.netSalesFormat.Aciklama2 = json!["NetSalesByFormat"]?.value(forKey: "Aciklama2") as? [String] ?? ["0"]
                    self.netSalesFormat.Format = json!["NetSalesByFormat"]?.value(forKey: "Format") as? [String] ?? ["0"]
                    self.netSalesFormat.Gelisim = json!["NetSalesByFormat"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    self.netSalesFormat.ColorFormat = json!["NetSalesByFormat"]?.value(forKey: "ColorFormat") as? [String] ?? ["0"]
                    self.netSalesCategory.Aciklama = json!["NetSalesByCategory"]?.value(forKey: "Aciklama") as? [String] ?? ["0"]
                    self.netSalesCategory.Category = json!["NetSalesByCategory"]?.value(forKey: "Category") as? [String] ?? ["0"]
                    self.netSalesCategory.Oran = json!["NetSalesByCategory"]?.value(forKey: "Oran") as? [String] ?? ["0"]
                    self.netSalesCiro.LastUpdate =  json!["NetSalesLastUpdate"]?.value(forKey: "LastUpdate") as? [String] ?? [""]
                    self.netSalesCiro.ActualCSA =  json!["ActualCSA"]?.value(forKey: "ActualCSA") as? [Double] ?? [0.0]
                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        
                        if json!["NetSalesByFormat"]?.value(forKey: "Format") as? [String] ?? ["0"] == ["0"] {
                            self.netSalesFormat.Format = ["0"]
                        } else {
                            self.netSalesFormat.Format = json!["NetSalesByFormat"]?.value(forKey: "Format") as? [String] ?? ["0"]
                        }
                        for i in 0..<self.netSalesCiro.Gelisim.count {
                            self.totalPrice.text = "\(Int(self.netSalesCiro.ActualCSA[0]))"
                            
                            if self.totalPrice.text?.count == 6 {
                                
                                self.totalPrice.text = "\(Int("\(self.netSalesCiro.ActualCSA[0])".dropLast(5) ) ?? 0) KTL"
                                
                            } else if self.totalPrice.text?.count == 7 {
                                
                                self.totalPrice.text = "\(Int("\(self.netSalesCiro.ActualCSA[0])".dropLast(8) ) ?? 0) MTL"
                            }
                            
                            let removeCharacters: Set<Character> = ["v", "s", " ", "%", "B"]
                            self.netSalesCiro.Gelisim[i].removeAll(where: { removeCharacters.contains($0) } )
//                            let removeCharactersLatUpdate: Set<Character> = ["T", ":"]
//                            self.netSalesCiro.LastUpdate[0].removeAll(where: { removeCharactersLatUpdate.contains($0) })
                            self.lastUpdateTİme.text = "Last Updated Time \(self.netSalesCiro.LastUpdate[0])"
                            
                            if self.netSalesCiro.Gelisim.count == 1 {
                                if Int(self.netSalesCiro.Gelisim[0].dropLast(2)) ?? 0 >= 0 {
                                    self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[0].dropLast(2))"
                                    self.MTL2021.text = "\(self.netSalesCiro.Ciro[0]) MTL"
                                    self.sales2021İmage.image = UIImage(named: "Up")
                                    self.percentage2021.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    
                                } else {
                                    self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[0].components(separatedBy: [" ", "-"]).joined().dropLast(2))"
                                    self.MTL2021.text = "\(self.netSalesCiro.Ciro[0].components(separatedBy: [" ", "-"]).joined()) MTL"
                                    self.sales2021İmage.image = UIImage(named: "down")
                                    self.MTL2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    self.percentage2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                } }
                            if self.netSalesCiro.Gelisim.count == 2 {
                                
                                if Int(self.netSalesCiro.Gelisim[0].dropLast(2)) ?? 0 >= 0 {
                                    self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[0].dropLast(2))"
                                    self.MTL2021.text = "\(self.netSalesCiro.Ciro[0]) MTL"
                                    self.sales2021İmage.image = UIImage(named: "Up")
                                    self.percentage2021.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    
                                } else {
                                    self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[0].components(separatedBy: [" ", "-"]).joined().dropLast(2))"
                                    self.MTL2021.text = "\(self.netSalesCiro.Ciro[0].components(separatedBy: [" ", "-"]).joined()) MTL"
                                    self.sales2021İmage.image = UIImage(named: "down")
                                    self.MTL2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    self.percentage2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                }
                                if Int(self.netSalesCiro.Gelisim[1].dropLast(2)) ?? 0 >= 0 {
                                    self.percentage2022B.text = "% \(self.netSalesCiro.Gelisim[1].trimmingCharacters(in: ["-"]).dropLast(2))"
                                    self.MTL2022B.text = "\(self.netSalesCiro.Ciro[1]) MTL"
                                    self.sales2022Bİmage.image = UIImage(named: "Up")
                                    self.percentage2022B.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    
                                } else {
                                    self.percentage2022B.text = "% \(self.netSalesCiro.Gelisim[1].components(separatedBy: [" ", "-"]).joined().dropLast(2))"
                                    self.MTL2022B.text = "\(self.netSalesCiro.Ciro[1].components(separatedBy: [" ", "-"]).joined()) MTL"
                                    self.sales2022Bİmage.image = UIImage(named: "down")
                                    self.MTL2022B.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    self.percentage2022B.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                }
                            }
                            if self.netSalesCiro.Gelisim.count == 3 {
                                if Int(self.netSalesCiro.Gelisim[0].dropLast(2)) ?? 0 >= 0 {
                                    self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[0].dropLast(2))"
                                    self.MTL2021.text = "\(self.netSalesCiro.Ciro[0]) MTL"
                                    self.sales2021İmage.image = UIImage(named: "Up")
                                    self.percentage2021.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    
                                } else {
                                    self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[0].components(separatedBy: [" ", "-"]).joined().dropLast(2))"
                                    self.MTL2021.text = "\(self.netSalesCiro.Ciro[0].components(separatedBy: [" ", "-"]).joined()) MTL"
                                    self.sales2021İmage.image = UIImage(named: "down")
                                    self.MTL2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    self.percentage2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                }
                                if Int(self.netSalesCiro.Gelisim[1].dropLast(2)) ?? 0 >= 0 {
                                    self.percentage2022B.text = "% \(self.netSalesCiro.Gelisim[1].dropLast(2))"
                                    self.MTL2022B.text = "\(self.netSalesCiro.Ciro[1]) MTL"
                                    self.sales2022Bİmage.image = UIImage(named: "Up")
                                    self.percentage2022B.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    
                                } else {
                                    self.percentage2022B.text = "% \(self.netSalesCiro.Gelisim[1].components(separatedBy: [" ", "-"]).joined().dropLast(2))"
                                    self.MTL2022B.text = "\(self.netSalesCiro.Ciro[1].components(separatedBy: [" ", "-"]).joined()) MTL"
                                    self.sales2022Bİmage.image = UIImage(named: "down")
                                    self.MTL2022B.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    self.percentage2022B.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                }
                                if Int(self.netSalesCiro.Gelisim[2].dropLast(2)) ?? 0 >= 0 {
                                    self.percentage2022LE.text = "% \(self.netSalesCiro.Gelisim[2].dropLast(2))"
                                    self.MTL2022LE.text = "\(self.netSalesCiro.Ciro[2]) MTL"
                                    self.sales2022LEimage.image = UIImage(named: "Up")
                                    self.percentage2022LE.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    
                                } else {
                                    self.percentage2022LE.text = "% \(self.netSalesCiro.Gelisim[2].components(separatedBy: [" ", "-"]).joined().dropLast(2))"
                                    self.MTL2022LE.text = "\(self.netSalesCiro.Ciro[2].components(separatedBy: [" ", "-"]).joined()) MTL"
                                    self.sales2022LEimage.image = UIImage(named: "down")
                                    self.MTL2022LE.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    self.percentage2022LE.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                }
                            }
                            
                            
                            
                        }
                        //MARK: CATEGORY
                        for index in 0..<self.netSalesCategory.Aciklama.count {
                            
                            
                            if self.netSalesCategory.Aciklama[index] == "0" {
                                
                                if self.netSalesCategory.Category[index] == "FMCG" {
                                    self.fmcgProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.fmcgPercLabel.text = "0"
                                    self.fmcgProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Fresh Food" {
                                    self.freshFoodProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.freshFoodPercLabel.text = "0"
                                    self.freshFoodProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Home" {
                                    self.homeProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.homePercLabel.text = "0"
                                    self.homeProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Textile" {
                                    self.textileProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.textfilePercLabel.text = "0"
                                    self.textileProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Electronics" {
                                    self.electronicProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.electronicPercLabel.text = "0"
                                    self.electronicProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Other" {
                                    self.otherProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.otherPercLabel.text = "0.0"
                                    self.otherProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Food" {
                                    self.foodProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.foodPercLabel.text = "0.0"
                                    self.foodProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Non Food" {
                                    self.nonFoodProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index])"
                                    self.nonFoodPercLabel.text = "0.0"
                                    self.nonFoodProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                            } else {
                                
                                let removeCharactersFormat: Set<Character> = ["v", "s", "%", "K", "T", "L", " "]
                                self.netSalesCategory.Oran[index].removeAll(where: { removeCharactersFormat.contains($0) } )
                                self.netSalesCategory.Aciklama[index].removeAll(where: { removeCharactersFormat.contains($0) } )

                                
                                if self.netSalesCategory.Category[index] == "FMCG" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.fmcgPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.fmcgİmage.image = UIImage(named: "Up")
                                        self.fmcgPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    } else {
                                        self.fmcgPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.fmcgİmage.image = UIImage(named: "down")
                                        self.fmcgPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }
                                    self.fmcgProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"

                                    self.fmcgProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Fresh Food" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.freshFoodPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.freshFoodİmage.image = UIImage(named: "Up")
                                        self.freshFoodPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)

                                    } else {
                                        self.freshFoodPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.freshFoodİmage.image = UIImage(named: "down")
                                        self.freshFoodPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }
                                    self.freshFoodProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.freshFoodProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                    
                                }
                                
                                if self.netSalesCategory.Category[index] == "Home" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.homePercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.homeİmage.image = UIImage(named: "Up")
                                        self.homePercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                        
                                    } else {
                                        self.homePercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.homeİmage.image = UIImage(named: "down")
                                        self.homePercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }

                                    self.homeProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.homeProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Textile" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.textfilePercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.textfileİmage.image = UIImage(named: "Up")
                                        self.textfilePercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    } else {
                                        self.textfilePercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.textfileİmage.image = UIImage(named: "down")
                                        self.textfilePercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }

                                    self.textileProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.textileProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Electronics" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.electronicPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.electronicİmage.image = UIImage(named: "Up")
                                        self.electronicPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)

                                    } else {
                                        self.electronicPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.electronicİmage.image = UIImage(named: "down")
                                        self.electronicPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }
                                    
                                    self.electronicProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.electronicProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Other" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.otherPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.otherİmage.image = UIImage(named: "Up")
                                        self.otherPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)

                                    } else {
                                        self.otherPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.otherİmage.image = UIImage(named: "down")
                                        self.otherPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }

                                    self.otherProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.otherProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                if self.netSalesCategory.Category[index] == "Food" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.foodPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.foodİmage.image = UIImage(named: "Up")
                                        self.foodPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    } else {
                                        self.foodPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.foodİmage.image = UIImage(named: "down")
                                        self.foodPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }
                                    
                                    self.foodProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.foodProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                                
                                if self.netSalesCategory.Category[index] == "Non Food" {
                                    if Double(self.netSalesCategory.Aciklama[index]) ?? 0.0 > 0.0 {
                                        
                                        self.nonFoodPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.nonFoodİmage.image = UIImage(named: "Up")
                                        self.nonFoodPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                    } else {
                                        self.nonFoodPercLabel.text = "\(self.netSalesCategory.Aciklama[index]) KTL"
                                        self.nonFoodİmage.image = UIImage(named: "down")
                                        self.nonFoodPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                    }

                                    self.nonFoodProgress.percentLabelFormat = "\(self.netSalesCategory.Oran[index].toDouble)"
                                    self.nonFoodProgress.setProgress(progress: Double((Double(self.netSalesCategory.Oran[index]) ?? 0.0) / 100), animated: true)
                                }
                            }
                        }
                        
                        //MARK: Format
                        for i in 0..<self.netSalesFormat.Aciklama1.count {
                            
                            self.netSalesFormat.Aciklama1[i].removeAll(where: { self.removeCharacters.contains($0) } )
                        }
                        
                        for index in 0..<self.netSalesFormat.Format.count {
        
                            self.netSalesFormat.Aciklama2[index].removeAll(where: { self.removeCharacters.contains($0) } )
                            
                        }
     
                        if self.netSalesCiro.Gelisim.count == 1 {
                            self.progress2021.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2021.setProgress((Float(self.netSalesCiro.Gelisim[0].dropLast(2)) ?? 0.0) / 100, animated: false)
                            
                        }
                        else if self.netSalesCiro.Gelisim.count == 2 {
                            self.progress2021.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2021.setProgress((Float(self.netSalesCiro.Gelisim[0].dropLast(2)) ?? 0.0) / 100, animated: false)
                            self.progress2022B.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2022B.setProgress((Float(self.netSalesCiro.Gelisim[1].dropLast(2)) ?? 0.0) / 100 , animated: false)
                        }
                        else if self.netSalesCiro.Gelisim.count == 3 {
                            self.progress2021.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2021.setProgress((Float(self.netSalesCiro.Gelisim[0].dropLast(2)) ?? 0.0) / 100, animated: false)
                            self.progress2022B.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2022B.setProgress((Float(self.netSalesCiro.Gelisim[1].dropLast(2)) ?? 0.0) / 100 , animated: false)
                            self.progress2022LE.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2022LE.setProgress((Float(self.netSalesCiro.Gelisim[2].dropLast(2)) ?? 0.0) / 100 , animated: false)
                        }
                        
                        self.setupPieChart()
                        self.storesTableView.reloadData()
                        self.chanelTableView.reloadData()
                        self.formatTableView.reloadData()

                    }
                    
                }
            }
        })
        task.resume()
    }
    func setupPieChart() {
        storesChartView.delegate = self
        storesChartView.chartDescription.enabled = false
        storesChartView.drawHoleEnabled = false
        storesChartView.rotationAngle = 0
        storesChartView.rotationEnabled = false
        //storesChartView.isUserInteractionEnabled = false
        storesChartView.drawEntryLabelsEnabled = true
        storesChartView.legend.enabled = false
        storesChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        chanelChartView.delegate = self
        chanelChartView.chartDescription.enabled = false
        chanelChartView.drawHoleEnabled = false
        chanelChartView.rotationAngle = 0
        chanelChartView.rotationEnabled = false
        //chanelChartView.isUserInteractionEnabled = false
        chanelChartView.drawEntryLabelsEnabled = true
        chanelChartView.legend.enabled = false
        chanelChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        
        var entriesStores: [PieChartDataEntry] = Array()
        var entriesChannel: [PieChartDataEntry] = Array()
        for i in 0..<netSalesStores.Oran.count {
            entriesStores.append(PieChartDataEntry(value: Double(netSalesStores.Oran[i]), label: "" ))
        }
        for i in 0..<netSalesChannel.Oran.count {
            entriesChannel.append(PieChartDataEntry(value: Double(netSalesChannel.Oran[i]), label: "" ))
        }
        
        let dataSetStores = PieChartDataSet(entries: entriesStores, label: "")
        let dataSetChannel = PieChartDataSet(entries: entriesChannel, label: "")
        
        var  colorsStore: [UIColor] = []
        for i in 0..<self.netSalesStores.ColorStores.count {
            colorsStore.append(UIColor(hexString: netSalesStores.ColorStores[i]))
        }
        var  colorsCategory: [UIColor] = []
        for i in 0..<self.netSalesChannel.ColorChannels.count {
            colorsCategory.append(UIColor(hexString: netSalesChannel.ColorChannels[i]))
        }
        
        dataSetStores.colors = colorsStore
        dataSetChannel.colors = colorsCategory
        
        dataSetStores.sliceSpace = 2
        dataSetStores.drawValuesEnabled = false
        dataSetChannel.sliceSpace = 2
        dataSetChannel.drawValuesEnabled = false
        storesChartView.data = PieChartData(dataSet: dataSetStores)
        storesChartView.notifyDataSetChanged()
        chanelChartView.data = PieChartData(dataSet: dataSetChannel)
        chanelChartView.notifyDataSetChanged()
        
    }
//    @IBAction func hourlyBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = true
//        yesterdayStoreButton.isSelected = false
//        daytodayStoreButton.isSelected = false
//        weeklyStoreButton.isSelected = false
//        monthlyStoreButton.isSelected = false
//        yeartodateStoreButton.isSelected = false
//        if netSalesSwitch.isOn == true {
//            if netSales2021Button.isSelected == true {
//                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
//                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
//                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
//                self.chartParameters = self.Parameters2021
//                self.netSales2021Button.isSelected = false
//
//            }
//            if netSales2022BButton.isSelected == true {
//                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
//                self.chartParameters = self.Parameters2022b
//
//            }
//            if netSales2022LEButton.isSelected == true {
//                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
//                self.chartParameters = self.Parameters2022LE
//
//            }
//        } else {
//            if netSales2021Button.isSelected == true {
//                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
//                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
//                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
//                self.chartParameters = self.Parameters2021
//                self.netSales2021Button.isSelected = false
//
//            }
//            if netSales2022BButton.isSelected == true {
//                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
//                self.chartParameters = self.Parameters2022b
//
//            }
//            if netSales2022LEButton.isSelected == true {
//                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
//                self.chartParameters = self.Parameters2022LE
//
//            }
//
//        }
//        if !self.netSalesCiro.Ciro.isEmpty {
//            hud.textLabel.text = "Loading"
//            hud.show(in: self.view)
//            self.checkNetSales()
//        }
//    else {
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        self.checkNetSales()
//    }
//        self.setupPieChart()
//        self.hourlyStoreView.backgroundColor = UIColor.white
//        self.hourlyStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
//        self.yesterdayStoreView.backgroundColor = UIColor.clear
//        self.yesterdayStoreLabel.textColor = UIColor.white
//        self.daytodayStoreView.backgroundColor = UIColor.clear
//        self.daytodayStoreLabel.textColor = UIColor.white
//        self.weeklyStoreView.backgroundColor = UIColor.clear
//        self.weeklyStoreLabel.textColor = UIColor.white
//        self.monthlyStoreView.backgroundColor = UIColor.clear
//        self.monthlyStoreLabel.textColor = UIColor.white
//        self.yeartodateStoreView.backgroundColor = UIColor.clear
//        self.yeartodateStoreLabel.textColor = UIColor.white
//    }
    
    @IBAction func yesterdayBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = false
        yesterdayStoreButton.isSelected = true
        daytodayStoreButton.isSelected = false
        weeklyStoreButton.isSelected = false
        monthlyStoreButton.isSelected = false
        yeartodateStoreButton.isSelected = false
        if netSalesSwitch.isOn == true {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
 
        } else {
            
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
            }
            
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
            }
            
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
        }
        
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        self.setupPieChart()
//        self.hourlyStoreView.backgroundColor = UIColor.clear
//        self.hourlyStoreLabel.textColor = UIColor.white
        self.yesterdayStoreView.backgroundColor = UIColor.white
        self.yesterdayStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.daytodayStoreView.backgroundColor = UIColor.clear
        self.daytodayStoreLabel.textColor = UIColor.white
        self.weeklyStoreView.backgroundColor = UIColor.clear
        self.weeklyStoreLabel.textColor = UIColor.white
        self.monthlyStoreView.backgroundColor = UIColor.clear
        self.monthlyStoreLabel.textColor = UIColor.white
        self.yeartodateStoreView.backgroundColor = UIColor.clear
        self.yeartodateStoreLabel.textColor = UIColor.white
    }
    
    @IBAction func daytodayBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = false
        yesterdayStoreButton.isSelected = false
        daytodayStoreButton.isSelected = true
        weeklyStoreButton.isSelected = false
        monthlyStoreButton.isSelected = false
        yeartodateStoreButton.isSelected = false
        if netSalesSwitch.isOn == true {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
                
            }

        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
        }
        
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        self.setupPieChart()
//        self.hourlyStoreView.backgroundColor = UIColor.clear
//        self.hourlyStoreLabel.textColor = UIColor.white
        self.yesterdayStoreView.backgroundColor = UIColor.clear
        self.yesterdayStoreLabel.textColor = UIColor.white
        self.daytodayStoreView.backgroundColor = UIColor.white
        self.daytodayStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.weeklyStoreView.backgroundColor = UIColor.clear
        self.weeklyStoreLabel.textColor = UIColor.white
        self.monthlyStoreView.backgroundColor = UIColor.clear
        self.monthlyStoreLabel.textColor = UIColor.white
        self.yeartodateStoreView.backgroundColor = UIColor.clear
        self.yeartodateStoreLabel.textColor = UIColor.white
    }
    
    @IBAction func weeklyBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = false
        yesterdayStoreButton.isSelected = false
        daytodayStoreButton.isSelected = false
        weeklyStoreButton.isSelected = true
        monthlyStoreButton.isSelected = false
        yeartodateStoreButton.isSelected = false
        if netSalesSwitch.isOn == true {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }

        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
        }
        
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        
        self.setupPieChart()
//        self.hourlyStoreView.backgroundColor = UIColor.clear
//        self.hourlyStoreLabel.textColor = UIColor.white
        self.yesterdayStoreView.backgroundColor = UIColor.clear
        self.yesterdayStoreLabel.textColor = UIColor.white
        self.daytodayStoreView.backgroundColor = UIColor.clear
        self.daytodayStoreLabel.textColor = UIColor.white
        self.weeklyStoreView.backgroundColor = UIColor.white
        self.weeklyStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.monthlyStoreView.backgroundColor = UIColor.clear
        self.monthlyStoreLabel.textColor = UIColor.white
        self.yeartodateStoreView.backgroundColor = UIColor.clear
        self.yeartodateStoreLabel.textColor = UIColor.white
    }
    
    @IBAction func monthlyBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = false
        yesterdayStoreButton.isSelected = false
        daytodayStoreButton.isSelected = false
        weeklyStoreButton.isSelected = false
        monthlyStoreButton.isSelected = true
        yeartodateStoreButton.isSelected = false
        if netSalesSwitch.isOn == true {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
            
        }
        
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        self.setupPieChart()
//        self.hourlyStoreView.backgroundColor = UIColor.clear
//        self.hourlyStoreLabel.textColor = UIColor.white
        self.yesterdayStoreView.backgroundColor = UIColor.clear
        self.yesterdayStoreLabel.textColor = UIColor.white
        self.daytodayStoreView.backgroundColor = UIColor.clear
        self.daytodayStoreLabel.textColor = UIColor.white
        self.weeklyStoreView.backgroundColor = UIColor.clear
        self.weeklyStoreLabel.textColor = UIColor.white
        self.monthlyStoreView.backgroundColor = UIColor.white
        self.monthlyStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        self.yeartodateStoreView.backgroundColor = UIColor.clear
        self.yeartodateStoreLabel.textColor = UIColor.white
    }
    
    @IBAction func yeartodateBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = false
        yesterdayStoreButton.isSelected = false
        daytodayStoreButton.isSelected = false
        weeklyStoreButton.isSelected = false
        monthlyStoreButton.isSelected = false
        yeartodateStoreButton.isSelected = true
        if netSalesSwitch.isOn == true {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2021\"}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2022B\"}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0,\"DateFormat\": \"2022LE\"}"
                self.chartParameters = self.Parameters2022LE
            }
        }
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        self.setupPieChart()
//        self.hourlyStoreView.backgroundColor = UIColor.clear
//        self.hourlyStoreLabel.textColor = UIColor.white
        self.yesterdayStoreView.backgroundColor = UIColor.clear
        self.yesterdayStoreLabel.textColor = UIColor.white
        self.daytodayStoreView.backgroundColor = UIColor.clear
        self.daytodayStoreLabel.textColor = UIColor.white
        self.weeklyStoreView.backgroundColor = UIColor.clear
        self.weeklyStoreLabel.textColor = UIColor.white
        self.monthlyStoreView.backgroundColor = UIColor.clear
        self.monthlyStoreLabel.textColor = UIColor.white
        self.yeartodateStoreView.backgroundColor = UIColor.white
        self.yeartodateStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        
    }
    
    @IBAction func netSales2021BtnPressed(_ sender: UIButton) {
        self.years = "2021"
        self.chartParameters = self.Parameters2021
        self.netSales2021Button.isSelected = true
        self.netSales2022BButton.isSelected = false
        self.netSales2022LEButton.isSelected = false
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        //        self.setupPieChart()
        self.netSales2021View.backgroundColor = UIColor.white
        self.netSales2021Label.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
        self.netSales2022BView.backgroundColor = UIColor.clear
        self.netSales2022BLabel.textColor = UIColor.white
        self.netSales2022LEView.backgroundColor = UIColor.clear
        self.netSales2022LELabel.textColor = UIColor.white
    }
    
    @IBAction func netSales2022BBtnPressed(_ sender: Any) {
        self.years = "2022B"
        self.chartParameters = self.Parameters2022b
        self.netSales2021Button.isSelected = false
        self.netSales2022BButton.isSelected = true
        self.netSales2022LEButton.isSelected = false
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        self.netSales2021View.backgroundColor = UIColor.clear
        self.netSales2021Label.textColor = UIColor.white
        self.netSales2022BView.backgroundColor = UIColor.white
        self.netSales2022BLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
        self.netSales2022LEView.backgroundColor = UIColor.clear
        self.netSales2022LELabel.textColor = UIColor.white
    }
    
    @IBAction func netSales2022LEBtnPressed(_ sender: Any) {
        self.years = "2022LE"
        self.chartParameters = self.Parameters2022LE
        self.netSales2021Button.isSelected = false
        self.netSales2022BButton.isSelected = false
        self.netSales2022LEButton.isSelected = true
        if !self.netSalesCiro.Ciro.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkNetSales()
        }
        //        self.setupPieChart()
        self.netSales2021View.backgroundColor = UIColor.clear
        self.netSales2021Label.textColor = UIColor.white
        self.netSales2022BView.backgroundColor = UIColor.clear
        self.netSales2022BLabel.textColor = UIColor.white
        self.netSales2022LEView.backgroundColor = UIColor.white
        self.netSales2022LELabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
    }
}


extension NetSalesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        if tableView == storesTableView {
            numberOfRow = self.netSalesStores.Oran.count
        }
        else if tableView == chanelTableView {
            numberOfRow = self.netSalesChannel.Oran.count
        }
        else if tableView == formatTableView {
            numberOfRow = self.netSalesFormat.Format.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "netSalesStoresCell", for: indexPath) as! StoresTableViewCell
            if !self.netSalesStores.ColorStores.isEmpty {
                let selectedColor = self.netSalesStores.ColorStores[indexPath.item]
                let selectedInfo = self.netSalesStores.Aciklama[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor)
            } else {
                let selectedColor = self.netSalesStores.ColorStores[0]
                let selectedInfo = self.netSalesStores.Aciklama[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor)
            }
            if !self.netSalesStores.Aciklama.isEmpty {
                let selectedColor = self.netSalesStores.ColorStores[indexPath.item]
                let selectedInfo = self.netSalesStores.Aciklama[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor)
            } else {
                let selectedColor = self.netSalesStores.ColorStores[indexPath.item]
                let selectedInfo = self.netSalesStores.Aciklama[0]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor)
            }
            cellToReturn = storeCell
            
            
        }  else if tableView == self.chanelTableView {
            let chanelCell = tableView.dequeueReusableCell(withIdentifier: "netSalesChanelCell", for: indexPath) as! ChanelTableViewCell
            if !self.netSalesChannel.ColorChannels.isEmpty {
                let selectedColor = self.netSalesChannel.ColorChannels[indexPath.item]
                let selectedInfo = self.netSalesChannel.Aciklama[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor)
            } else {
                let selectedColor = self.netSalesChannel.ColorChannels[0]
                let selectedInfo = self.netSalesChannel.Aciklama[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor)
            }
            if !self.netSalesChannel.Aciklama.isEmpty {
                let selectedColor = self.netSalesChannel.ColorChannels[indexPath.item]
                let selectedInfo = self.netSalesChannel.Aciklama[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor)
            } else {
                let selectedColor = self.netSalesChannel.ColorChannels[indexPath.item]
                let selectedInfo = self.netSalesChannel.Aciklama[0]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor)
            }
            
            cellToReturn = chanelCell
            
        } else if tableView == self.formatTableView {
            let formatCell = tableView.dequeueReusableCell(withIdentifier: "netSalesFormatCell", for: indexPath) as! FormatTableViewCell
     
            if !self.netSalesFormat.ColorFormat.isEmpty {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            } else {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[0]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            }
            if !self.netSalesFormat.Format.isEmpty {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            } else {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[0]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            }
            if !self.netSalesFormat.Aciklama2.isEmpty {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            } else {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[0]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            }
            if !self.netSalesFormat.Aciklama1.isEmpty {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            } else {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[0]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            }
            if !self.netSalesFormat.Gelisim.isEmpty {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            } else {
                let years = self.years
                let selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
                let selectedFormat = self.netSalesFormat.Format[indexPath.item]
                let isPrice = self.netSalesFormat.Aciklama2[indexPath.item]
                let isprogress = self.netSalesFormat.Aciklama1[indexPath.item]
                let isGelisim = self.netSalesFormat.Gelisim[0]
                formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, price: isPrice, gelisim: isGelisim, years: years)
                
            }
            cellToReturn = formatCell
        }
        
        return cellToReturn
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var numberOfHeight = 1
        if tableView == storesTableView {
            numberOfHeight = 30
        }
        else if tableView == chanelTableView {
            numberOfHeight = 30
        }
        else if tableView == formatTableView {
            numberOfHeight = 70
        }
        return CGFloat(numberOfHeight)
    }
}





