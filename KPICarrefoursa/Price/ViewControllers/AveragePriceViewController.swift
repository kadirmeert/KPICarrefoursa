//
//  AveragePriceViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit
import Charts
import CryptoSwift
import JGProgressHUD

class AveragePriceViewController: UIViewController, ChartViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var storesChartView: PieChartView!
    @IBOutlet weak var storesTableView: UITableView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryChartView: PieChartView!
    @IBOutlet weak var categoryTableView: UITableView!
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
    @IBOutlet weak var scrool: UIScrollView!
    @IBOutlet weak var lastUpdateTime: UILabel!
    @IBOutlet weak var priceStoresTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var priceCategoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var priceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var priceSwitch: UISwitch!
    
    
    @IBOutlet weak var priceLflLabel: UILabel!
    //MARK: Properties
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    var priceStores = PriceStores()
    var priceCategory = PriceCategory()
    var hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    var selectedCiro = 0.0
    var selectedColor = ""
    var selectedInfo = ""
    var selectedCategoryGelisim = ""
    var selectedStoresGelisim = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        if self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        self.refreshControl.tintColor = UIColor.gray
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        self.scrool.isScrollEnabled = true
        self.scrool.alwaysBounceVertical = true
        scrool.addSubview(refreshControl)
        prepareUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillLayoutSubviews() {
        self.priceStoresTableViewHeight.constant = self.storesTableView.contentSize.height
        self.priceCategoryTableViewHeight.constant = self.categoryTableView.contentSize.height
        if self.priceStores.Stores.count > 5 {
            self.priceViewHeight.constant = 1500
        }
    }
    @objc func refresh(sender:AnyObject) {
        self.checkChartData()
        refreshControl.endRefreshing()
        
    }
    func prepareUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        storesView.dropShadow(cornerRadius: 12)
        categoryView.dropShadow(cornerRadius: 12)
//        hourlyView.layer.cornerRadius = 12
//        hourlyLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        yesterdayLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        yesterdayView.layer.cornerRadius = 12
        daytodayView.layer.cornerRadius = 12
        weeklyView.layer.cornerRadius = 12
        monthlyView.layer.cornerRadius = 12
        yeartodateView.layer.cornerRadius = 12
        self.yesterdayButton.isSelected = true

    }
    @IBAction func didPriceValueChanged(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.priceLflLabel.text = "LFL"
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
            self.priceLflLabel.text = "ALL"
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
        if !self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    func checkChartData() {
        print(chartParameters)
        let enUrlParams = try! chartParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        print(stringRequest)
        let url = URL(string: PriceUrl)!
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
//                    self.priceStores.Ciro = json!["AveragePriceByStores"]?.value(forKey: "Ciro") as? [Double] ?? [0.0]
                    self.priceStores.Stores = json!["AveragePriceByStores"]?.value(forKey: "Stores") as? [String] ?? ["0"]
                    self.priceStores.AveragePrice = json!["AveragePriceByStores"]?.value(forKey: "AveragePrice") as? [Double] ?? [0.0]
                    self.priceStores.ColorStores = json!["AveragePriceByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.priceStores.Last_Update =  json!["AveragePriceByStores"]?.value(forKey: "Last_Update") as? [String] ?? [""]
                    self.priceStores.Gelisim = json!["AveragePriceByStores"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]


//                    self.priceCategory.Ciro = json!["AveragePriceByCategory"]?.value(forKey: "Ciro") as? [Double] ?? [0.0]
                    self.priceCategory.AveragePrice = json!["AveragePriceByCategory"]?.value(forKey: "AveragePrice") as? [Double] ?? [0.0]
                    self.priceCategory.CategoryBreakDown = json!["AveragePriceByCategory"]?.value(forKey: "CategoryBreakDown") as? [String] ?? ["0"]
                    self.priceCategory.ColorCategory = json!["AveragePriceByCategory"]?.value(forKey: "ColorCategory") as? [String] ?? ["0"]
                    self.priceCategory.Gelisim = json!["AveragePriceByCategory"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]


                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                     
//                        let removeCharactersLatUpdate: Set<Character> = ["T"]
//                        self.priceStores.LastUpdate[0].removeAll(where: { removeCharactersLatUpdate.contains($0) })
                        if self.priceStores.Last_Update.isEmpty {
                            self.lastUpdateTime.text = "00/00/00 00:00:00"
                            
                        } else {
                            self.lastUpdateTime.text = "Last Updated Time \(self.priceStores.Last_Update[0])"

                        }
                        
                        self.setupPieChart()
                        self.storesTableView.reloadData()
                        self.categoryTableView.reloadData()
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
        //        storesChartView.isUserInteractionEnabled = false
        storesChartView.drawEntryLabelsEnabled = true
        storesChartView.legend.enabled = false
        storesChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        categoryChartView.delegate = self
        categoryChartView.chartDescription.enabled = false
        categoryChartView.drawHoleEnabled = false
        categoryChartView.rotationAngle = 0
        categoryChartView.rotationEnabled = false
        //        categoryChartView.isUserInteractionEnabled = false
        categoryChartView.drawEntryLabelsEnabled = true
        categoryChartView.legend.enabled = false
        categoryChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        
        var entriesStores: [PieChartDataEntry] = Array()
        var entriesChannel: [PieChartDataEntry] = Array()
        for i in 0..<priceStores.Stores.count {
            entriesStores.append(PieChartDataEntry(value: Double(self.priceStores.AveragePrice[i]) , label: ""))
        }
        for i in 0..<priceCategory.CategoryBreakDown.count {
            entriesChannel.append(PieChartDataEntry(value: Double(self.priceCategory.AveragePrice[i]) , label: ""))
        }
        
        let dataSetStores = PieChartDataSet(entries: entriesStores, label: "")
        let dataSetChannel = PieChartDataSet(entries: entriesChannel, label: "")
        
        var  colorsStore: [UIColor] = []
        for i in 0..<self.priceStores.ColorStores.count {
            colorsStore.append(UIColor(hexString: priceStores.ColorStores[i]))
        }
        var  colorsCategory: [UIColor] = []
        for i in 0..<self.priceCategory.ColorCategory.count {
            colorsCategory.append(UIColor(hexString: priceCategory.ColorCategory[i]))
        }
        
        dataSetStores.colors = colorsStore
        dataSetChannel.colors = colorsCategory
       
        
        dataSetStores.sliceSpace = 2
        dataSetStores.drawValuesEnabled = false
        dataSetChannel.sliceSpace = 2
        dataSetChannel.drawValuesEnabled = false
        storesChartView.data = PieChartData(dataSet: dataSetStores)
        storesChartView.notifyDataSetChanged()
        categoryChartView.data = PieChartData(dataSet: dataSetChannel)
        categoryChartView.notifyDataSetChanged()
    }
//    @IBAction func hourlyBtnPressed(_ sender: UIButton) {
//        hourlyButton.isSelected = true
//        yesterdayButton.isSelected = false
//        daytodayButton.isSelected = false
//        weeklyButton.isSelected = false
//        monthlyButton.isSelected = false
//        yeartodateButton.isSelected = false
//        if priceSwitch.isOn == true {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
//
//        } else {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
//        }
//        if !self.priceStores.Stores.isEmpty {
//            hud.textLabel.text = "Loading"
//            hud.show(in: self.view)
//            self.checkChartData()
//        }
//        else {
//            hud.textLabel.text = "Loading"
//            hud.show(in: self.view)
//            self.checkChartData()
//        }
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
    
    @IBAction func yesterdayBtnPressed(_ sender: UIButton) {
//        hourlyButton.isSelected = false
        yesterdayButton.isSelected = true
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        
        if priceSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
        }
        if !self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
    
    @IBAction func daytodayBtnPressed(_ sender: UIButton) {
        //        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = true
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if priceSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 0}"
        }
        if !self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        if priceSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
        }
        if !self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        if priceSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
        }
        if !self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        if priceSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0}"
        }

        if !self.priceStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
    
}

extension AveragePriceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        if tableView == storesTableView {
            numberOfRow = self.priceStores.Stores.count
        }
        else if tableView == categoryTableView {
            numberOfRow = self.priceCategory.CategoryBreakDown.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "priceStoreCell", for: indexPath) as! PriceStoresTableViewCell
            
            if self.priceStores.ColorStores.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.priceStores.ColorStores[indexPath.item]
            }
            
            if self.priceStores.AveragePrice.count <= 1 {
                self.selectedCiro = 0.0

            } else {
                self.selectedCiro = self.priceStores.AveragePrice[indexPath.item]
            }
            if self.priceStores.Stores.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.priceStores.Stores[indexPath.item]

            }
            if self.priceStores.Gelisim.count <= 1 {
                self.selectedStoresGelisim = ""
                
            } else {
                self.selectedStoresGelisim = self.priceStores.Gelisim[indexPath.item]
            }
            
            storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro, gelisim: selectedStoresGelisim)
        
            cellToReturn = storeCell
            
            
        }  else if tableView == self.categoryTableView {
            let chanelCell = tableView.dequeueReusableCell(withIdentifier: "priceCategoryCell", for: indexPath) as! PriceCategoryTableViewCell
            
            if self.priceCategory.ColorCategory.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.priceCategory.ColorCategory[indexPath.item]
            }
            
            if self.priceCategory.AveragePrice.count <= 1 {
                self.selectedCiro = 0.0

            } else {
            self.selectedCiro = self.priceCategory.AveragePrice[indexPath.item]
            }
            if self.priceCategory.CategoryBreakDown.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.priceCategory.CategoryBreakDown[indexPath.item]

            }
            if self.priceCategory.Gelisim.count <= 1 {
                self.selectedCategoryGelisim = ""
                
            } else {
                self.selectedCategoryGelisim = self.priceCategory.Gelisim[indexPath.item]
            }
            chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro, gelisim: selectedCategoryGelisim)
        
            cellToReturn = chanelCell
        }
        return cellToReturn
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}




