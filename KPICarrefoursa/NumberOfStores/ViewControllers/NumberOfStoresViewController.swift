//
//  NumberOfStoresViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 11.10.2022.
//

import UIKit
import Charts
import CryptoSwift
import JGProgressHUD


class NumberOfStoresViewController: UIViewController, ChartViewDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var numberOfStoresSwitch: UISwitch!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
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
    @IBOutlet weak var actualTotalView: UIView!
    @IBOutlet weak var actualTotalLabel: UILabel!
    @IBOutlet weak var scrool: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var numberOfStoresHeight: NSLayoutConstraint!
    @IBOutlet weak var numberOfStoresLflLabel: UILabel!
    //MARK: Properties
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    var numberOfStores = NumberOfStores()
    let hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    var selectedColor = ""
    var selectedFormat = ""
    var selectedArea = 0
    var selectedCity = 0
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat =  "MM-dd-yyyy HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.numberOfStores.Format.isEmpty {
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
        self.setupPieChart()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.storesView.dropShadow(cornerRadius: 12)
        numberOfStoresSwitch.set(width: 40, height: 18)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        self.tableViewHeight.constant = self.tableView.contentSize.height
      
        if self.numberOfStores.Format.count > 6 {
            self.numberOfStoresHeight.constant = 900
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
//        hourlyStoreView.layer.cornerRadius = 12
//        hourlyStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        yesterdayStoreLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
        yesterdayStoreView.layer.cornerRadius = 12
        daytodayStoreView.layer.cornerRadius = 12
        weeklyStoreView.layer.cornerRadius = 12
        monthlyStoreView.layer.cornerRadius = 12
        yeartodateStoreView.layer.cornerRadius = 12
        storesView.layer.cornerRadius = 12
        actualTotalView.dropShadow(cornerRadius: 12)
        self.yesterdayStoreButton.isSelected = true

    }
    
    @IBAction func didNumberOfStoresValueChanged(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.numberOfStoresLflLabel.text = "LFL"
//            if hourlyStoreButton.isSelected == true {
//                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
//            }
            if yesterdayStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            }
            if daytodayStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1}"
            }
            if weeklyStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            }
            if monthlyStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            }
            if yeartodateStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1}"
            }
        }
        else{
            self.numberOfStoresLflLabel.text = "ALL"
//            if hourlyStoreButton.isSelected == true {
//                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
//            }
            if yesterdayStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
            }
            if daytodayStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0}"
            }
            if weeklyStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
            }
            if monthlyStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
            }
            if yeartodateStoreButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0}"
            }
        }
        if !self.numberOfStores.Format.isEmpty {
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
        let url = URL(string: Chart)!
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
                    self.numberOfStores.Area = json!["Stores"]?.value(forKey: "Area") as? [Int] ?? [0]
                    print(self.numberOfStores.Area)
                    self.numberOfStores.City = json!["Stores"]?.value(forKey: "City") as? [Int] ?? [0]
                    self.numberOfStores.Color = json!["Stores"]?.value(forKey: "Color") as? [String] ?? ["0"]
                    self.numberOfStores.Format = json!["Stores"]?.value(forKey: "Format") as? [String] ?? ["0"]
                    self.numberOfStores.LastUpdate = json!["Stores"]?.value(forKey: "LastUpdate") as? [String] ?? ["0"]
                    self.numberOfStores.StoreNumber = json!["Stores"]?.value(forKey: "StoreNumber") as? [Int] ?? [0]
                    
                    DispatchQueue.main.async {
                        if self.numberOfStores.LastUpdate.isEmpty {
                            self.lastTimeLabel.text = "00/00/00 00:00:00"
                            self.actualTotalLabel.text = " 0 Stores (0K m2) - 0 City"
                            
                        } else {
                            
                            for index in 0...self.numberOfStores.LastUpdate.count-1 {
                                self.lastTimeLabel.text = "Last Updated Time \(self.numberOfStores.LastUpdate[index])"
//                                let dateFormatter1 = DateFormatter()
//                                dateFormatter1.dateFormat = "dd/MM/yyyy HH:mm:ss"
//                                if let recordDate = self.dateFormatter.date(from: self.numberOfStores.LastUpdate[index]){
//                                    let dateText = dateFormatter1.string(from: recordDate)
//                                    self.lastTimeLabel.text = "Last Updated Time \(dateText)"
//                                }
                                
                                if self.numberOfStores.Format[index] == "Actual CSA Total" {
                                    
                                    self.actualTotalLabel.text = "\(self.numberOfStores.StoreNumber[index]) Stores (\(self.numberOfStores.Area[index] / 1000)K m2) - \(self.numberOfStores.City[index]) City"
                                    self.numberOfStores.StoreNumber.removeLast()
                                    self.numberOfStores.Format.removeLast()
                                    
                                }
                            }
                        }
                        self.hud.dismiss()
                        self.setupPieChart()
                        self.tableView.reloadData()
                    }
                    
//                    DispatchQueue.main.async {
//
//                    }
                }
            }
        })
        task.resume()
    }
    
    func setupPieChart() {
        pieChartView.delegate = self
        pieChartView.chartDescription.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = false
        pieChartView.isUserInteractionEnabled = false
        pieChartView.drawEntryLabelsEnabled = true
        pieChartView.legend.enabled = false
        pieChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        
        var entriesData: [PieChartDataEntry] = Array()
        for i in 0..<numberOfStores.StoreNumber.count {
            entriesData.append(PieChartDataEntry(value: Double(numberOfStores.StoreNumber[i]), label:   "\(self.numberOfStores.StoreNumber[i])"))
            
        }
        let dataSet = PieChartDataSet(entries: entriesData, label: "")
        
        var  colors: [UIColor] = []
        for i in 0..<numberOfStores.Color.count {
            colors.append(UIColor(hexString: numberOfStores.Color[i]))
        }
        dataSet.colors = colors
        dataSet.sliceSpace = 2
        dataSet.drawValuesEnabled = false
        pieChartView.data = PieChartData(dataSet: dataSet)
        pieChartView.notifyDataSetChanged()
    }
    
//    @IBAction func hourlyBtnPressed(_ sender: Any) {
//        hourlyStoreButton.isSelected = true
//        yesterdayStoreButton.isSelected = false
//        daytodayStoreButton.isSelected = false
//        weeklyStoreButton.isSelected = false
//        monthlyStoreButton.isSelected = false
//        yesterdayStoreButton.isSelected = false
//        if numberOfStoresSwitch.isOn == true {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1}"
//
//        } else {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0}"
//        }
//        if !self.numberOfStores.Format.isEmpty {
//            hud.textLabel.text = "Loading"
//            hud.show(in: self.view)
//            self.checkChartData()
//        }
//        else {
//            hud.textLabel.text = "Loading"
//            hud.show(in: self.view)
//            self.checkChartData()
//        }
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
        if numberOfStoresSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
        }
        if !self.numberOfStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        yesterdayStoreButton.isSelected = false
        if numberOfStoresSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0}"
        }
        if !self.numberOfStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        yesterdayStoreButton.isSelected = false
        if numberOfStoresSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
        }
        if !self.numberOfStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        yesterdayStoreButton.isSelected = false
        if numberOfStoresSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
        }
        if !self.numberOfStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
        yesterdayStoreButton.isSelected = true
        if numberOfStoresSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0}"
        }
        if !self.numberOfStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
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
}
extension NumberOfStoresViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfStores.Format.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeCell = tableView.dequeueReusableCell(withIdentifier: "numberOfStoresCell", for: indexPath) as! NumberOfStoresTableViewCell
        
        if self.numberOfStores.Color.count <= 1 {
            self.selectedColor = ""
            
        } else {
            self.selectedColor = self.numberOfStores.Color[indexPath.item]
        }
        
        if self.numberOfStores.Format.count <= 1 {
            self.selectedFormat = ""
            
        } else {
            self.selectedFormat = self.numberOfStores.Format[indexPath.item]
        }
        if self.numberOfStores.Area.count <= 1 {
            self.selectedArea = 0
            
        } else {
            self.selectedArea = self.numberOfStores.Area[indexPath.item]
        }
        if self.numberOfStores.City.count <= 1 {
            self.selectedCity = 0
            
        } else {
            self.selectedCity = self.numberOfStores.City[indexPath.item]
        }
    
        storeCell.prepareCell(format: selectedFormat, color: selectedColor, area: selectedArea, city: selectedCity)
    
        return storeCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
