//
//  ProductViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit
import Charts
import CryptoSwift
import JGProgressHUD
import FSCalendar

class ProductViewController: UIViewController, ChartViewDelegate,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
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
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productStoresHeight: NSLayoutConstraint!
    @IBOutlet weak var productCategoryHeight: NSLayoutConstraint!
    @IBOutlet weak var productViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productSwitch: UISwitch!
    @IBOutlet weak var productLflLabel: UILabel!
    @IBOutlet weak var productMonthView: UIView!
    @IBOutlet weak var JAN: BaseButton!
    @IBOutlet weak var FEB: BaseButton!
    @IBOutlet weak var MAR: BaseButton!
    @IBOutlet weak var APR: BaseButton!
    @IBOutlet weak var MAY: BaseButton!
    @IBOutlet weak var JUN: BaseButton!
    @IBOutlet weak var JULY: BaseButton!
    @IBOutlet weak var AUG: BaseButton!
    @IBOutlet weak var SEP: BaseButton!
    @IBOutlet weak var OCT: BaseButton!
    @IBOutlet weak var NOV: BaseButton!
    @IBOutlet weak var DEC: BaseButton!
    @IBOutlet weak var productMonthsDetailLabel: UILabel!
    @IBOutlet weak var productWeekStackView: UIStackView!
    @IBOutlet weak var productCalendar: FSCalendar!
    @IBOutlet weak var productWeekDetailLabel: UILabel!
    
    //MARK: Properties
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
    var productStores = ProductStores()
    var productCategory = ProductCategory()
    var hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    var selectedProduct = ""
    var selectedColor = ""
    var selectedInfo = ""
    var selectedCategoryGelisim = ""
    var selectedStoresGelisim = ""
    var formatter = DateFormatter()
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productWeekDetailLabel.text = ""
//  MARK: - Calendar
        productCalendar.delegate = self
        productCalendar.dataSource = self
        
        productCalendar.appearance.headerDateFormat = "MMMM yyyy"
        productCalendar.scope = .month
        productCalendar.scrollDirection = .horizontal
        productCalendar.placeholderType = .fillHeadTail
        
        // Ay isimlerinin rengini mavi yapalım
        productCalendar.appearance.headerTitleColor =  UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        productCalendar.appearance.headerTitleFont = UIFont(name: "Montserrat-Bold", size: 17)
        
        
        // Hafta sayısı görüntülemek için ayarlar
        productCalendar.appearance.weekdayTextColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        productCalendar.appearance.weekdayFont = UIFont(name: "Montserrat-Medium", size: 17)
        productCalendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
        productCalendar.firstWeekday = 2
        
        //       MARK: -GÜNLER
        productCalendar.appearance.todayColor = .clear
        productCalendar.appearance.titleSelectionColor = .black
        productCalendar.appearance.titleDefaultColor = UIColor.black
        
        // Özel hücre sınıfını kaydetme
        productCalendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
        JAN.backgroundColor = .white
        FEB.backgroundColor = .white
        MAR.backgroundColor = .white
        APR.backgroundColor = .white
        MAY.backgroundColor = .white
        JUN.backgroundColor = .white
        JULY.backgroundColor = .white
        AUG.backgroundColor = .white
        SEP.backgroundColor = .white
        OCT.backgroundColor = .white
        NOV.backgroundColor = .white
        DEC.backgroundColor = .white
        productMonthsDetailLabel.text = ""
        if self.productStores.Stores.isEmpty {
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
    //    MARK: -CALENDAR SETTİNGS
    
//    func getWeekNumber(date: Date) -> Int {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.firstWeekday = 2 // Pazartesi günü başlaması için 2 olarak ayarla
//        let dateComponents = calendar.dateComponents([.weekOfYear], from: date)
//        return dateComponents.weekOfYear!
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, canSelect date: Date) -> Bool {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        
        let thisMonth = calendar.dateComponents([.year, .month], from: Date())
        
        if components.year == thisMonth.year && components.month == thisMonth.month {
            return true // Bu ayın tarihleri seçilebilir
        } else {
            return false // Diğer tarihler seçilemez
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if calendar.today == date {
            return UIColor.red
        }
        return UIColor.black
    }
    
    // Hafta sayısı görüntülemek için gerekli olan iki fonksiyon
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as! CustomCalendarCell
        let weekday = Calendar.current.component(.weekday, from: date)
        let weekOfYear = Calendar.current.component(.weekOfYear, from: date)
        let isMonday = weekday == 2
        cell.weekNumberLabel.isHidden = !isMonday // Hafta numarası etiketini sadece pazartesi günlerinde göster
        if isMonday {
            cell.weekNumber = "\(weekOfYear)"
        }
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let cell = cell as! CustomCalendarCell
        let weekday = Calendar.current.component(.weekday, from: date)
        let weekOfYear = Calendar.current.component(.weekOfYear, from: date)
        cell.weekNumberLabel.text = "\(weekOfYear)"
        cell.weekNumberLabel.isHidden = weekday != 2 // Hafta numarası etiketini sadece pazartesi günlerinde göster
        if weekday == 2 {
            cell.weekNumber = "\(weekOfYear)"
        }
    }
    func calendar(_ calendar: FSCalendar, numberOfRowsInMonth month: Int) -> Int {
        let date = calendar.currentPage
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        let numberOfWeeks = ceil(Double(range.count) / 7.0)
        return Int(numberOfWeeks)
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let weekOfYear = Calendar.current.component(.weekOfYear, from: date)
        User.weekNumber = weekOfYear
        
        
        // Check if selected date is a Monday
//        let weekday = Calendar.current.component(.weekday, from: date)
        // Get the first day of the week
        var startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        
        // Add or subtract days to include all days of the week
        while !Calendar.current.dateInterval(of: .weekOfYear, for: startOfWeek)!.contains(date) {
            if startOfWeek < date {
                startOfWeek = Calendar.current.date(byAdding: .day, value: 1, to: startOfWeek)!
            } else {
                startOfWeek = Calendar.current.date(byAdding: .day, value: -1, to: startOfWeek)!
            }
        }
        let daysOfWeek = (0...6).map { Calendar.current.date(byAdding: .day, value: $0, to: startOfWeek)! }
        
        // Change background color of selected cell and other cells for the week
        var selectedDates = [Date]()
        for day in daysOfWeek {
            let cell = calendar.cell(for: day, at: FSCalendarMonthPosition.current) as? CustomCalendarCell
            if selectedDates.contains(day) {
                // If the cell was already selected, deselect it and reset its appearance
                cell?.isCellSelected = false
                cell?.backgroundColor = .clear
                cell?.titleLabel.textColor = UIColor.black
                cell?.appearance.selectionColor = .clear
            } else {
                // If the cell was not already selected, select it and update its appearance
                cell?.isCellSelected = true
                cell?.backgroundColor = UIColor.lightGray
                cell?.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                cell?.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                //                    cell.appearance.titleSelectionColor = UIColor.red
                //                    cell.appearance.eventSelectionColor = UIColor.red
            }
            
            selectedDates.append(day)
        }
        for day in daysOfWeek {
            let cell = calendar.cell(for: day, at: FSCalendarMonthPosition.previous) as? CustomCalendarCell
            if selectedDates.contains(day) {
                // If the cell was not already selected, select it and update its appearance
                cell?.isCellSelected = true
                cell?.backgroundColor = UIColor.lightGray
                cell?.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                cell?.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                //                    cell.appearance.titleSelectionColor = UIColor.red
                //                    cell.appearance.eventSelectionColor = UIColor.red
             
            } else {
                // If the cell was already selected, deselect it and reset its appearance
                cell?.isCellSelected = false
                cell?.backgroundColor = .clear
                cell?.titleLabel.textColor = UIColor.black
                cell?.appearance.selectionColor = .clear
            }
            
            selectedDates.append(day)
        }
        for day in daysOfWeek {
            let cell = calendar.cell(for: day, at: FSCalendarMonthPosition.next) as? CustomCalendarCell
            if selectedDates.contains(day) {
                // If the cell was not already selected, select it and update its appearance
                cell?.isCellSelected = true
                cell?.backgroundColor = UIColor.lightGray
                cell?.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                cell?.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                //                    cell.appearance.titleSelectionColor = UIColor.red
                //                    cell.appearance.eventSelectionColor = UIColor.red
             
            } else {
                // If the cell was already selected, deselect it and reset its appearance
                cell?.isCellSelected = false
                cell?.backgroundColor = .clear
                cell?.titleLabel.textColor = UIColor.black
                cell?.appearance.selectionColor = .clear
            }
            
            selectedDates.append(day)
        }
        
        // Deselect cells from other weeks
        let allCells = calendar.visibleCells()
        for cell in allCells {
            if let customCell = cell as? CustomCalendarCell,
               let cellDate = calendar.date(for: customCell) {
                if !selectedDates.contains(cellDate) {
                    customCell.isCellSelected = false
                    customCell.backgroundColor = .clear
                    customCell.titleLabel.textColor = UIColor.black
                    customCell.appearance.selectionColor = .clear
                } else {
                    customCell.titleLabel.textColor = UIColor.black
                }
            }
        }
        if productSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
        }
        if !self.productStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        productWeekDetailLabel.text = "\(weekOfYear). Week"
        productWeekStackView.isHidden = true
    }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        for cell in calendar.visibleCells() {
            cell.backgroundColor = UIColor.white
            calendar.reloadData()
            calendar.setCurrentPage(calendar.currentPage, animated: false)
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let cell = calendar.cell(for: date, at: monthPosition) as? CustomCalendarCell {
            cell.isCellSelected = false
        }
    }
    // Özel hücre sınıfı
    class CustomCalendarCell: FSCalendarCell {
        
        var weekNumberLabel: UILabel!
        
        var isCellSelected: Bool = false {
            didSet {
                weekNumberLabel.textColor = isCellSelected ? .white : UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            }
        }
        var weekNumber: String? {
            didSet {
                weekNumberLabel.text = weekNumber
            }
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            // Hafta sayısı etiketi
            weekNumberLabel = UILabel()
            weekNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            weekNumberLabel.font = UIFont(name: "Montserrat-Bold", size: 9)
            weekNumberLabel.textAlignment = .center
            weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            contentView.addSubview(weekNumberLabel)
            
            // Hafta sayısı etiketinin yerleşimi
            NSLayoutConstraint.activate([
                weekNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                weekNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                weekNumberLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                weekNumberLabel.heightAnchor.constraint(equalToConstant: 16)
            ])
            
            // Takvim hücrelerinin konumlarını ayarla
            self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            self.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1) // mavi renk
            self.subtitleLabel?.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: -5).isActive = true
            self.subtitleLabel?.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1) // mavi renk
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = true
        }
        
        required init!(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupPieChart()
        
    }
    override func viewWillLayoutSubviews() {
        self.productStoresHeight.constant = self.storesTableView.contentSize.height
        self.productCategoryHeight.constant = self.categoryTableView.contentSize.height
        if self.productCategory.CategoryBreakDown.count > 6 {
            self.productViewHeight.constant = 1500
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
    @IBAction func DidChangeProductValue(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.productLflLabel.text = "LFL"
//            if hourlyButton.isSelected == true {
//                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 1}"
//            }
            if yesterdayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
            if daytodayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
            if weeklyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
            }
            if monthlyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
            }
            if yeartodateButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
        }
        else{
            self.productLflLabel.text = "ALL"
//            if hourlyButton.isSelected == true {
//                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0}"
//            }

            if yesterdayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
            if daytodayButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
            if weeklyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
            }
            if monthlyButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
            }
            if yeartodateButton.isSelected == true {
                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
        }
        if !self.productStores.Stores.isEmpty {
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
        let url = URL(string: ProductUrl)!
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
                    
                    self.productStores.FiiliUrun = json!["ProductByStores"]?.value(forKey: "FiiliUrun") as? [Double] ?? [0.0]
                    self.productStores.urun = json!["ProductByStores"]?.value(forKey: "urun") as? [String] ?? ["0"]
                    self.productStores.Stores = json!["ProductByStores"]?.value(forKey: "Stores") as? [String] ?? ["0"]
                    self.productStores.ColorStores = json!["ProductByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.productStores.Gelisim = json!["ProductByStores"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]

                    
                    self.productCategory.FiiliUrun = json!["ProductByCategory"]?.value(forKey: "FiiliUrun") as? [Double] ?? [0.0]
                    self.productCategory.Urun = json!["ProductByCategory"]?.value(forKey: "Urun") as? [String] ?? ["0"]
                    self.productCategory.CategoryBreakDown = json!["ProductByCategory"]?.value(forKey: "CategoryBreakDown") as? [String] ?? ["0"]
                    self.productStores.Last_Update =  json!["ProductByStores"]?.value(forKey: "Last_Update") as? [String] ?? [""]
                    self.productCategory.ColorCategory = json!["ProductByCategory"]?.value(forKey: "ColorCategory") as? [String] ?? ["000"]
                    self.productCategory.Gelisim = json!["ProductByCategory"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]


                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
//                        let removeCharactersLatUpdate: Set<Character> = ["T", ":"]
//                        self.productStores.LastUpdate[0].removeAll(where: { removeCharactersLatUpdate.contains($0) })
                        if self.productStores.Last_Update.isEmpty {
                            
                            self.lastUpdateTime.text = "00/00/0000 00:00:00"
                            
                        } else {
                            self.lastUpdateTime.text = "Last Updated Time \(self.productStores.Last_Update[0])"
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
        for i in 0..<productStores.Stores.count  {
            entriesStores.append(PieChartDataEntry(value: self.productStores.FiiliUrun[i], label: ""))
        }
        for i in 0..<productCategory.CategoryBreakDown.count {
            entriesChannel.append(PieChartDataEntry(value: Double(self.productCategory.FiiliUrun[i]), label: ""))
        }
        
        let dataSetStores = PieChartDataSet(entries: entriesStores, label: "")
        let dataSetChannel = PieChartDataSet(entries: entriesChannel, label: "")
        
        var  colorsStore: [UIColor] = []
        for i in 0..<self.productStores.ColorStores.count {
            colorsStore.append(UIColor(hexString: productStores.ColorStores[i]))
        }
        var  colorsCategory: [UIColor] = []
        for i in 0..<self.productCategory.ColorCategory.count {
            colorsCategory.append(UIColor(hexString: productCategory.ColorCategory[i]))
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
    //    MARK: - Months Button Pressed
        
        @IBAction func MonthsButtonPressed(_ sender: BaseButton) {
            if sender.titleLabel?.text ?? "" == JAN.titleLabel?.text {
                JAN.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                JAN.tintColor = .white
                User.monthsNumber = 1
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
            } else {
                JAN.backgroundColor = .white
                JAN.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == FEB.titleLabel?.text {
                FEB.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                FEB.tintColor = .white
                User.monthsNumber = 2
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true

            } else {
                FEB.backgroundColor = .white
                FEB.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == MAR.titleLabel?.text {
                MAR.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                MAR.tintColor = .white
                User.monthsNumber = 3
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
            } else {
                MAR.backgroundColor = .white
                MAR.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == APR.titleLabel?.text {
                APR.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                APR.tintColor = .white
                User.monthsNumber = 4
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
                
            } else {
                APR.backgroundColor = .white
                APR.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == MAY.titleLabel?.text {
                MAY.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                MAY.tintColor = .white
                User.monthsNumber = 5
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
            } else {
                MAY.backgroundColor = .white
                MAY.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == JUN.titleLabel?.text {
                JUN.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                JUN.tintColor = .white
                User.monthsNumber = 6
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true

            } else {
                JUN.backgroundColor = .white
                JUN.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == JULY.titleLabel?.text {
                JULY.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                JULY.tintColor = .white
                User.monthsNumber = 7
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true

            } else {
                JULY.backgroundColor = .white
                JULY.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == AUG.titleLabel?.text {
                AUG.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                AUG.tintColor = .white
                User.monthsNumber = 8
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true

            } else {
                AUG.backgroundColor = .white
                AUG.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == SEP.titleLabel?.text {
                SEP.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                SEP.tintColor = .white
                User.monthsNumber = 9
                productMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
            } else {
                SEP.backgroundColor = .white
                SEP.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == OCT.titleLabel?.text {
                OCT.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                OCT.tintColor = .white
                User.monthsNumber = 10
                productMonthsDetailLabel.text = "\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true

            } else {
                OCT.backgroundColor = .white
                OCT.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == NOV.titleLabel?.text {
                NOV.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                NOV.tintColor = .white
                User.monthsNumber = 11
                productMonthsDetailLabel.text = "\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
            } else {
                NOV.backgroundColor = .white
                NOV.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == DEC.titleLabel?.text {
                DEC.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                DEC.tintColor = .white
                User.monthsNumber = 12
                productMonthsDetailLabel.text = "\(User.monthsNumber)/2023"
                if productSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.productStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                productMonthView.isHidden = true
                
            } else {
                DEC.backgroundColor = .white
                DEC.tintColor = .black
            }
            
        }
    
//    @IBAction func hourlyBtnPressed(_ sender: UIButton) {
//        hourlyButton.isSelected = true
//        yesterdayButton.isSelected = false
//        daytodayButton.isSelected = false
//        weeklyButton.isSelected = false
//        monthlyButton.isSelected = false
//        yeartodateButton.isSelected = false
//        if productSwitch.isOn == true {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 1}"
//
//        } else {
//            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 1}"
//        }
//        if !self.productStores.Stores.isEmpty {
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
//
    @IBAction func yesterdayBtnPressed(_ sender: UIButton) {
        productMonthView.isHidden = true
        productWeekStackView.isHidden = true
//        hourlyButton.isSelected = false
        yesterdayButton.isSelected = true
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        
        if productSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
        }
        if !self.productStores.Stores.isEmpty {
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
        productMonthView.isHidden = true
        productWeekStackView.isHidden = true
//        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = true
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
        if productSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"

        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DaytoDay\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
        }
        if !self.productStores.Stores.isEmpty {
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
        productMonthView.isHidden = true
        productWeekStackView.isHidden.toggle()
        let topOffset = CGPoint(x: 0, y: 0)
        scrool.setContentOffset(topOffset, animated: true)
//        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = true
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = false
     
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
        productWeekStackView.isHidden = true
        productMonthView.isHidden.toggle()
        let topOffset = CGPoint(x: 0, y: 0)
        scrool.setContentOffset(topOffset, animated: true)
        let currentDate = Date()
        let currentMonth = Calendar.current.component(.month, from: currentDate)
        if currentMonth == 1 {
            FEB.alpha = 0.5 ; FEB.isUserInteractionEnabled = false ; MAR.alpha = 0.5 ; MAR.isUserInteractionEnabled = false ; APR.alpha = 0.5 ; APR.isUserInteractionEnabled = false ; MAY.alpha = 0.5 ; MAY.isUserInteractionEnabled = false ; JUN.alpha = 0.5 ; JUN.isUserInteractionEnabled = false ; JULY.alpha = 0.5 ; JULY.isUserInteractionEnabled = false ; AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 2 {
            MAR.alpha = 0.5 ; MAR.isUserInteractionEnabled = false ; APR.alpha = 0.5 ; APR.isUserInteractionEnabled = false ; MAY.alpha = 0.5 ; MAY.isUserInteractionEnabled = false ; JUN.alpha = 0.5 ; JUN.isUserInteractionEnabled = false ; JULY.alpha = 0.5 ; JULY.isUserInteractionEnabled = false ; AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 3 {
            APR.alpha = 0.5 ; APR.isUserInteractionEnabled = false ; MAY.alpha = 0.5 ; MAY.isUserInteractionEnabled = false ; JUN.alpha = 0.5 ; JUN.isUserInteractionEnabled = false ; JULY.alpha = 0.5 ; JULY.isUserInteractionEnabled = false ; AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 4 {
            MAY.alpha = 0.5 ; MAY.isUserInteractionEnabled = false ; JUN.alpha = 0.5 ; JUN.isUserInteractionEnabled = false ; JULY.alpha = 0.5 ; JULY.isUserInteractionEnabled = false ; AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 5 {
            JUN.alpha = 0.5 ; JUN.isUserInteractionEnabled = false ; JULY.alpha = 0.5 ; JULY.isUserInteractionEnabled = false ; AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 6 {
            JULY.alpha = 0.5 ; JULY.isUserInteractionEnabled = false ; AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 7 {
            AUG.alpha = 0.5 ; AUG.isUserInteractionEnabled = false ; SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 8 {
            SEP.alpha = 0.5 ; SEP.isUserInteractionEnabled = false ; OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 9 {
            OCT.alpha = 0.5 ; OCT.isUserInteractionEnabled = false ; NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 10 {
            NOV.alpha = 0.5 ; NOV.isUserInteractionEnabled = false ; DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
        if currentMonth == 11 {
            DEC.alpha = 0.5 ; DEC.isUserInteractionEnabled = false
        }
//        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = true
        yeartodateButton.isSelected = false
      
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
        productWeekStackView.isHidden = true
        productMonthView.isHidden = true
//        hourlyButton.isSelected = false
        yesterdayButton.isSelected = false
        daytodayButton.isSelected = false
        weeklyButton.isSelected = false
        monthlyButton.isSelected = false
        yeartodateButton.isSelected = true
        if productSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
        }
        if !self.productStores.Stores.isEmpty {
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
extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        if tableView == storesTableView {
            numberOfRow = self.productStores.Stores.count
        }
        else if tableView == categoryTableView {
            numberOfRow = self.productCategory.CategoryBreakDown.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "productStoreCell", for: indexPath) as! ProductStoresTableViewCell
            
            if self.productStores.ColorStores.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.productStores.ColorStores[indexPath.item]
            }
            
            if self.productStores.urun.count <= 1 {
                self.selectedProduct = ""
                
            } else {
                self.selectedProduct = self.productStores.urun[indexPath.item]
            }
            if self.productStores.Stores.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.productStores.Stores[indexPath.item]
            }
            if self.productStores.Gelisim.count <= 1 {
                self.selectedStoresGelisim = ""
                
            } else {
                self.selectedStoresGelisim = self.productStores.Gelisim[indexPath.item]
            }


            storeCell.prepareCell(info: selectedInfo , color: selectedColor, product: selectedProduct,gelisim: selectedStoresGelisim)
            
            cellToReturn = storeCell
            
            
        }  else if tableView == self.categoryTableView {
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "productCategoryCell", for: indexPath) as! ProductCategoryTableViewCell
            
            
            if self.productCategory.ColorCategory.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.productCategory.ColorCategory[indexPath.item]
            }
            
            if self.productCategory.Urun.count <= 1 {
                self.selectedProduct = ""
                
            } else {
                self.selectedProduct = self.productCategory.Urun[indexPath.item]
            }
            if self.productCategory.CategoryBreakDown.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.productCategory.CategoryBreakDown[indexPath.item]
                
            }
            if self.productCategory.Gelisim.count <= 1 {
                self.selectedCategoryGelisim = ""
                
            } else {
                self.selectedCategoryGelisim = self.productCategory.Gelisim[indexPath.item]
            }
            categoryCell.prepareCell(info: selectedInfo, color: selectedColor, product: selectedProduct, gelisim: selectedCategoryGelisim)
                
           
            cellToReturn = categoryCell
        }
        return cellToReturn
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
