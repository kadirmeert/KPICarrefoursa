//
//  CustomerViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit
import Charts
import CryptoSwift
import JGProgressHUD

class CustomerViewController: UIViewController, ChartViewDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var storesTableView: UITableView!
    @IBOutlet weak var storesChartView: PieChartView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var chanelChartView: PieChartView!
    @IBOutlet weak var chanelTableView: UITableView!
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
    @IBOutlet weak var lastUpdateTİme: UILabel!
    @IBOutlet weak var storesTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var customerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var customerSwitch: UISwitch!
    @IBOutlet weak var customerLflLabel: UILabel!
    
    //MARK: Properties
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    var customerStores = CustomerStores()
    var customerCategory = CustomerCategory()
    let hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.customerStores.Format.isEmpty {
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
        self.setupPieChart()
        
    }
    override func viewWillLayoutSubviews() {
        self.storesTableViewHeight.constant = self.storesTableView.contentSize.height
        self.categoryTableViewHeight.constant = self.chanelTableView.contentSize.height
        if self.customerStores.Format.count > 6 {
            self.customerViewHeight.constant = 1500
        }
    }
    @objc func refresh(sender:AnyObject) {
        if !self.customerStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
            refreshControl.endRefreshing()
        }
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
    }
    @IBAction func DidValueChanged(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.customerLflLabel.text = "LFL"
            //            if hourlyButton.isSelected == true {
            //                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            //            }
            self.yesterdayButton.isSelected = true
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
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1}"
            }
        }
        else{
            self.customerLflLabel.text = "ALL"
            
            //            if hourlyButton.isSelected == true {
            //                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
            //            }
            self.yesterdayButton.isSelected = true
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
            
            if yesterdayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0}"
            }
        }
        
        if !self.customerStores.Format.isEmpty {
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
        let enUrlParams = try! chartParameters.aesEncrypt(key: LoginConstants.xApiKey, iv: LoginConstants.IV)
        print(enUrlParams)
        let stringRequest = "\"\(enUrlParams)\""
        print(stringRequest)
        let url = URL(string: CustomerUrl)!
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
                    
                    self.customerStores.Ciro = json!["CustomerByStores"]?.value(forKey: "Ciro") as? [Double] ?? [0.0]
                    self.customerStores.Ciro2021 = json!["CustomerByStores"]?.value(forKey: "Ciro2021") as? [Double] ?? [0.0]
                    self.customerStores.Format = json!["CustomerByStores"]?.value(forKey: "Format") as? [String] ?? ["0"]
                    self.customerStores.ColorStores = json!["CustomerByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.customerStores.Oran = json!["CustomerByStores"]?.value(forKey: "Oran") as? [Double] ?? [0.0]
                    self.customerCategory.Ciro = json!["CustomerByCategory"]?.value(forKey: "Ciro") as? [Double] ?? [0.0]
                    self.customerCategory.Ciro2021 = json!["CustomerByCategory"]?.value(forKey: "Ciro2021") as? [Double] ?? [0.0]
                    self.customerCategory.Category = json!["CustomerByCategory"]?.value(forKey: "Category") as? [String] ?? ["0"]
                    self.customerStores.LastUpdate =  json!["CustomerLastUpdate"]?.value(forKey: "LastUpdate") as? [String] ?? [""]
                    self.customerCategory.ColorCategory = json!["CustomerByCategory"]?.value(forKey: "ColorCategory") as? [String] ?? ["0"]
                    self.customerCategory.Oran = json!["CustomerByCategory"]?.value(forKey: "Oran") as? [Double] ?? [0.0]
                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
//                        let removeCharactersLatUpdate: Set<Character> = ["T", ":"]
//                        self.customerStores.LastUpdate[0].removeAll(where: { removeCharactersLatUpdate.contains($0) })
                        self.lastUpdateTİme.text = "Last Updated Time \(self.customerStores.LastUpdate[0])"
                        self.setupPieChart()
                        self.storesTableView.reloadData()
                        self.chanelTableView.reloadData()
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
        for i in 0..<customerStores.Format.count {
            entriesStores.append(PieChartDataEntry(value: self.customerStores.Oran[i] , label: ""))
        }
        for i in 0..<customerCategory.Category.count {
            entriesChannel.append(PieChartDataEntry(value: self.customerCategory.Oran[i] , label: ""))
        }
        
        let dataSetStores = PieChartDataSet(entries: entriesStores, label: "")
        let dataSetChannel = PieChartDataSet(entries: entriesChannel, label: "")
        
        var  colorsStore: [UIColor] = []
        for i in 0..<self.customerStores.ColorStores.count {
            colorsStore.append(UIColor(hexString: customerStores.ColorStores[i]))
        }
        var  colorsCategory: [UIColor] = []
        for i in 0..<self.customerCategory.ColorCategory.count {
            colorsCategory.append(UIColor(hexString: customerCategory.ColorCategory[i]))
        }
        
        dataSetStores.colors = colorsStore
        dataSetChannel.colors = colorsCategory
        
        dataSetStores.sliceSpace = 1
        dataSetStores.drawValuesEnabled = false
        dataSetChannel.sliceSpace = 1
        dataSetChannel.drawValuesEnabled = false
        
        storesChartView.data = PieChartData(dataSet: dataSetStores)
        storesChartView.notifyDataSetChanged()
        chanelChartView.data = PieChartData(dataSet: dataSetChannel)
        chanelChartView.notifyDataSetChanged()
    }
    
    //@IBAction func hourlyBtnPressed(_ sender: UIButton) {
    //    hourlyButton.isSelected = true
    //    yesterdayButton.isSelected = false
    //    daytodayButton.isSelected = false
    //    weeklyButton.isSelected = false
    //    monthlyButton.isSelected = false
    //    yeartodateButton.isSelected = false
    //    if customerSwitch.isOn == true {
    //        self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    //
    //    } else {
    //        self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
    //    }
    //    if !self.customerStores.Format.isEmpty {
    //        hud.textLabel.text = "Loading"
    //        hud.show(in: self.view)
    //        self.checkChartData()
    //    }
    //    else {
    //        hud.textLabel.text = "Loading"
    //        hud.show(in: self.view)
    //        self.checkChartData()
    //    }
    //    self.hourlyView.backgroundColor = UIColor.white
    //    self.hourlyLabel.textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
    //    self.yesterdayView.backgroundColor = UIColor.clear
    //    self.yesterdayLabel.textColor = UIColor.white
    //    self.daytodayView.backgroundColor = UIColor.clear
    //    self.daytodayLabel.textColor = UIColor.white
    //    self.weeklyView.backgroundColor = UIColor.clear
    //    self.weeklyLabel.textColor = UIColor.white
    //    self.monthlyView.backgroundColor = UIColor.clear
    //    self.monthlyLabel.textColor = UIColor.white
    //    self.yeartodateView.backgroundColor = UIColor.clear
    //    self.yeartodateLabel.textColor = UIColor.white
    //}
    
    @IBAction func yesterdayBtnPressed(_ sender: UIButton) {
        //    hourlyButton.isSelected = false
        yesterdayButton.isSelected = true
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if customerSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
        }
        if !self.customerStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        //    self.hourlyView.backgroundColor = UIColor.clear
        //    self.hourlyLabel.textColor = UIColor.white
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
        //    hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = true
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if customerSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 0}"
        }
        if !self.customerStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        //    self.hourlyView.backgroundColor = UIColor.clear
        //    self.hourlyLabel.textColor = UIColor.white
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
        //    hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = true
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if customerSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
        }
        if !self.customerStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        //    self.hourlyView.backgroundColor = UIColor.clear
        //    self.hourlyLabel.textColor = UIColor.white
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
        //    hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = true
        yeartodateButton.isSelected = false
        if customerSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
        }
        if !self.customerStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        } else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        //    self.hourlyView.backgroundColor = UIColor.clear
        //    self.hourlyLabel.textColor = UIColor.white
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
        //    hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = true
        if customerSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0}"
        }
        if !self.customerStores.Format.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        } else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        //    self.hourlyView.backgroundColor = UIColor.clear
        //    self.hourlyLabel.textColor = UIColor.white
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
extension CustomerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        if tableView == storesTableView {
            numberOfRow = self.customerStores.Format.count
        }
        else if tableView == chanelTableView {
            numberOfRow = self.customerCategory.Category.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "customerStoreCell", for: indexPath) as! CustomerStoreTableViewCell
            
            if !self.customerStores.Ciro.isEmpty {
                let selectedCiro = self.customerStores.Ciro[indexPath.item]
                let selectedColor = self.customerStores.ColorStores[indexPath.item]
                let selectedInfo = self.customerStores.Format[indexPath.item]
                storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            else {
                let selectedCiro = self.customerStores.Ciro[0]
                let selectedColor = self.customerStores.ColorStores[indexPath.item]
                let selectedInfo = self.customerStores.Format[indexPath.item]
                storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            
            if !self.customerStores.ColorStores.isEmpty {
                let selectedCiro = self.customerStores.Ciro[indexPath.item]
                let selectedColor = self.customerStores.ColorStores[indexPath.item]
                let selectedInfo = self.customerStores.Format[indexPath.item]
                storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            else {
                let selectedCiro = self.customerStores.Ciro[indexPath.item]
                let selectedColor = self.customerStores.ColorStores[0]
                let selectedInfo = self.customerStores.Format[indexPath.item]
                storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            if !self.customerStores.Format.isEmpty {
                let selectedCiro = self.customerStores.Ciro[indexPath.item]
                let selectedColor = self.customerStores.ColorStores[indexPath.item]
                let selectedInfo = self.customerStores.Format[indexPath.item]
                storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            else {
                let selectedCiro = self.customerStores.Ciro[indexPath.item]
                let selectedColor = self.customerStores.ColorStores[indexPath.item]
                let selectedInfo = self.customerStores.Format[0]
                storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            cellToReturn = storeCell
            
            
        }  else if tableView == self.chanelTableView {
            let chanelCell = tableView.dequeueReusableCell(withIdentifier: "customerCategoryCell", for: indexPath) as! CustomerCategoryTableViewCell
            
            if !self.customerCategory.Ciro.isEmpty {
                let selectedCiro = self.customerCategory.Ciro[indexPath.item]
                let selectedColor = self.customerCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.customerCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.customerCategory.Ciro[0]
                let selectedColor = self.customerCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.customerCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            if !self.customerCategory.ColorCategory.isEmpty {
                let selectedCiro = self.customerCategory.Ciro[indexPath.item]
                let selectedColor = self.customerCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.customerCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.customerCategory.Ciro[indexPath.item]
                let selectedColor = self.customerCategory.ColorCategory[0]
                let selectedInfo = self.customerCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            if !self.customerCategory.Category.isEmpty {
                let selectedCiro = self.customerCategory.Ciro[indexPath.item]
                let selectedColor = self.customerCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.customerCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.customerCategory.Ciro[indexPath.item]
                let selectedColor = self.customerCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.customerCategory.Category[0]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            
            cellToReturn = chanelCell
        }
        return cellToReturn
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
        
    }
    
}
