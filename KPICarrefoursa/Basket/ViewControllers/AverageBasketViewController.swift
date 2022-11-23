//
//  AverageBasketViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit
import Charts
import CryptoSwift
import JGProgressHUD

class AverageBasketViewController: UIViewController,ChartViewDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var storesView: UIView!
    @IBOutlet weak var storesTableView: UITableView!
    @IBOutlet weak var storesChartView: PieChartView!
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
    @IBOutlet weak var basketStoresTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var basketCategoryTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var basketViewHeight: NSLayoutConstraint!
    @IBOutlet weak var basketSwitch: UISwitch!
    
    @IBOutlet weak var basketLflLabel: UILabel!
    //MARK: Properties
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
    var basketStores = BasketStores()
    var basketCategory = BasketCategory()
    var hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.basketStores.Stores.isEmpty {
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
        //        self.setupPieChart()
        
    }
    
 
    override func viewWillLayoutSubviews() {
        self.basketStoresTableViewHeight.constant = self.storesTableView.contentSize.height 
        self.basketCategoryTableViewHeight.constant = self.categoryTableView.contentSize.height
        if self.basketStores.Stores.count > 5 {
            self.basketViewHeight.constant = 1500
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
    }
    
    @IBAction func basketDidValueChanged(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.basketLflLabel.text = "LFL"
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
            self.basketLflLabel.text = "ALL"
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
            if yeartodateButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0}"
            }
        }
        if !self.basketStores.Stores.isEmpty {
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
        let url = URL(string: BasketUrl)!
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
                    self.basketStores.Ciro = json!["AverageBasketByStores"]?.value(forKey: "Ciro") as? [Double] ?? [0.0]
                    self.basketStores.AverageBasket = json!["AverageBasketByStores"]?.value(forKey: "AverageBasket") as? [Double] ?? [0.0]
                    self.basketStores.Stores = json!["AverageBasketByStores"]?.value(forKey: "Stores") as? [String] ?? ["0"]
                    self.basketStores.Oran = json!["AverageBasketByStores"]?.value(forKey: "Oran") as? [Double] ?? [0.0]
                    self.basketStores.ColorStores = json!["AverageBasketByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.basketCategory.Ciro = json!["AverageBasketByCategory"]?.value(forKey: "Ciro") as? [Double] ?? [0.0]
                    self.basketCategory.AverageBasket = json!["AverageBasketByCategory"]?.value(forKey: "AverageBasket") as? [Double] ?? [0.0]
                    self.basketCategory.Category = json!["AverageBasketByCategory"]?.value(forKey: "Category") as? [String] ?? ["0"]
                    self.basketStores.LastUpdate =  json!["BasketLastUpdate"]?.value(forKey: "LastUpdate") as? [String] ?? [""]
                    self.basketCategory.ColorCategory = json!["AverageBasketByCategory"]?.value(forKey: "ColorCategory") as? [String] ?? ["0"]

                    DispatchQueue.main.async {
                        self.hud.dismiss()
//                        let removeCharactersLatUpdate: Set<Character> = ["T", ":"]
//                        self.basketStores.LastUpdate[0].removeAll(where: { removeCharactersLatUpdate.contains($0) })
                        self.lastUpdateTime.text = "Last Updated Time \(self.basketStores.LastUpdate[0])"
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
        //storesChartView.isUserInteractionEnabled = false
        storesChartView.drawEntryLabelsEnabled = true
        storesChartView.legend.enabled = false
        storesChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        categoryChartView.delegate = self
        categoryChartView.chartDescription.enabled = false
        categoryChartView.drawHoleEnabled = false
        categoryChartView.rotationAngle = 0
        categoryChartView.rotationEnabled = false
        //categoryChartView.isUserInteractionEnabled = false
        categoryChartView.drawEntryLabelsEnabled = true
        categoryChartView.legend.enabled = false
        categoryChartView.transparentCircleColor = NSUIColor(white: 1.0, alpha: 105.0/255.0)
        
        var entriesStores: [PieChartDataEntry] = Array()
        var entriesChannel: [PieChartDataEntry] = Array()
        for i in 0..<basketStores.Stores.count {
            entriesStores.append(PieChartDataEntry(value: Double(self.basketStores.Oran[i]), label: ""))
        }
        for i in 0..<basketCategory.Category.count {
            entriesChannel.append(PieChartDataEntry(value: Double(self.basketCategory.AverageBasket[i]), label: ""))
        }
        
        let dataSetStores = PieChartDataSet(entries: entriesStores, label: "")
        let dataSetChannel = PieChartDataSet(entries: entriesChannel, label: "")
        
        var  colorsStore: [UIColor] = []
        for i in 0..<self.basketStores.ColorStores.count {
            colorsStore.append(UIColor(hexString: basketStores.ColorStores[i]))
        }
        var  colorsCategory: [UIColor] = []
        for i in 0..<self.basketCategory.ColorCategory.count {
            colorsCategory.append(UIColor(hexString: basketCategory.ColorCategory[i]))
        }
        
        dataSetStores.colors = colorsStore
        dataSetChannel.colors = colorsCategory
        
        dataSetStores.sliceSpace = 1
        dataSetStores.drawValuesEnabled = false
        dataSetChannel.sliceSpace = 1
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
//        if basketSwitch.isOn == true {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
//
//        } else {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
//        }
//        if !self.basketStores.Stores.isEmpty {
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
        if basketSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
        }
        if !self.basketStores.Stores.isEmpty {
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
        if basketSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 0}"
        }
        if !self.basketStores.Stores.isEmpty {
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
        if basketSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0}"
        }
        if !self.basketStores.Stores.isEmpty {
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
        if basketSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0}"
        }
        if !self.basketStores.Stores.isEmpty {
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
        if basketSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 1}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YearToDate\",\"IsLfl\": 0}"
        }
        if !self.basketStores.Stores.isEmpty {
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
extension AverageBasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        if tableView == storesTableView {
            numberOfRow = self.basketStores.Stores.count
        }
        else if tableView == categoryTableView {
            numberOfRow = self.basketCategory.Category.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "basketStoreCell", for: indexPath) as! BasketStoresTableViewCell
            if !self.basketStores.Ciro.isEmpty {
                let selectedCiro = self.basketStores.Ciro[indexPath.item]
                let selectedColor = self.basketStores.ColorStores[indexPath.item]
                let selectedInfo = self.basketStores.Stores[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.basketStores.Ciro[0]
                let selectedColor = self.basketStores.ColorStores[indexPath.item]
                let selectedInfo = self.basketStores.Stores[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro)
            }
            if !self.basketStores.ColorStores.isEmpty {
                let selectedCiro = self.basketStores.Ciro[indexPath.item]
                let selectedColor = self.basketStores.ColorStores[indexPath.item]
                let selectedInfo = self.basketStores.Stores[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.basketStores.Ciro[indexPath.item]
                let selectedColor = self.basketStores.ColorStores[0]
                let selectedInfo = self.basketStores.Stores[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro)
            }
            if !self.basketStores.Stores.isEmpty {
                let selectedCiro = self.basketStores.Ciro[indexPath.item]
                let selectedColor = self.basketStores.ColorStores[indexPath.item]
                let selectedInfo = self.basketStores.Stores[indexPath.item]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.basketStores.Ciro[indexPath.item]
                let selectedColor = self.basketStores.ColorStores[indexPath.item]
                let selectedInfo = self.basketStores.Stores[0]
                storeCell.prepareCell(info: selectedInfo , color: selectedColor, ciro: selectedCiro)
            }
            cellToReturn = storeCell
            
            
        }  else if tableView == self.categoryTableView {
            let chanelCell = tableView.dequeueReusableCell(withIdentifier: "basketCategoryCell", for: indexPath) as! BasketCategoryTableViewCell
            if !self.basketCategory.Ciro.isEmpty {
                let selectedCiro = self.basketCategory.Ciro[indexPath.item]
                let selectedColor = self.basketCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.basketCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.basketCategory.Ciro[0]
                let selectedColor = self.basketCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.basketCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            if !self.basketCategory.ColorCategory.isEmpty {
                let selectedCiro = self.basketCategory.Ciro[indexPath.item]
                let selectedColor = self.basketCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.basketCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.basketCategory.Ciro[indexPath.item]
                let selectedColor = self.basketCategory.ColorCategory[0]
                let selectedInfo = self.basketCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            }
            if !self.basketCategory.Category.isEmpty {
                let selectedCiro = self.basketCategory.Ciro[indexPath.item]
                let selectedColor = self.basketCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.basketCategory.Category[indexPath.item]
                chanelCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro)
            } else {
                let selectedCiro = self.basketCategory.Ciro[indexPath.item]
                let selectedColor = self.basketCategory.ColorCategory[indexPath.item]
                let selectedInfo = self.basketCategory.Category[0]
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
