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
import FSCalendar

class CustomerViewController: UIViewController, ChartViewDelegate,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
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
    @IBOutlet weak var monthCustomerView: UIView!
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
    @IBOutlet weak var customerMonthDetailLabel: UILabel!
    @IBOutlet weak var customerWeekStackView: UIStackView!
    @IBOutlet weak var customerCalendar: FSCalendar!
    
    @IBOutlet weak var customerWeekDetailLabel: UILabel!
    
    
    //MARK: Properties
    var months : [BaseButton] = []
    var buttons : [UIButton] = []
    var arrayView : [UIView] = []
    var arrayLabel : [UILabel] = []
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
    var customerStores = CustomerStores()
    var customerCategory = CustomerCategory()
    let hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    var selectedCiro = ""
    var selectedColor = ""
    var selectedInfo = ""
    var selectedStoresGelisim = ""
    var selectedCategoryGelisim = ""
    var formatter = DateFormatter()
    var selectedDate: Date?
    var datesToBeDisabled: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayLabel.append(yesterdayLabel) ;  arrayLabel.append(daytodayLabel) ;  arrayLabel.append(weeklyLabel) ;  arrayLabel.append(monthlyLabel) ;  arrayLabel.append(yeartodateLabel)
        
        arrayView.append(yesterdayView) ;  arrayView.append(daytodayView) ;  arrayView.append(weeklyView) ;  arrayView.append(monthlyView) ;  arrayView.append(yeartodateView)
        
        buttons.append(yesterdayButton) ;  buttons.append(daytodayButton) ;  buttons.append(weeklyButton) ;  buttons.append(monthlyButton) ;  buttons.append(yeartodateButton)
        
        months.append(JAN) ;  months.append(FEB) ;  months.append(MAR) ;  months.append(APR) ;  months.append(MAY) ;  months.append(JUN) ; months.append(JULY) ; months.append(AUG) ;  months.append(SEP) ;  months.append(OCT) ;  months.append(NOV) ;  months.append(DEC)
        for i in 0..<months.count {
            months[i].alpha = 0.5
            months[i].isUserInteractionEnabled = false
        }
        customerWeekDetailLabel.text = ""
        //  MARK: - Calendar
        customerCalendar.delegate = self
        customerCalendar.dataSource = self
        
        customerCalendar.appearance.headerDateFormat = "MMMM yyyy"
        customerCalendar.scope = .month
        customerCalendar.scrollDirection = .horizontal
        customerCalendar.placeholderType = .fillHeadTail
        
        // Ay isimlerinin rengini mavi yapalım
        customerCalendar.appearance.headerTitleColor =  UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        customerCalendar.appearance.headerTitleFont = UIFont(name: "Montserrat-Bold", size: 17)
        
        
        // Hafta sayısı görüntülemek için ayarlar
        customerCalendar.appearance.weekdayTextColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        customerCalendar.appearance.weekdayFont = UIFont(name: "Montserrat-Medium", size: 17)
        customerCalendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
        customerCalendar.firstWeekday = 2
        
        //       MARK: -GÜNLER
        customerCalendar.appearance.todayColor = .clear
        customerCalendar.appearance.titleSelectionColor = .black
        customerCalendar.appearance.titleDefaultColor = UIColor.black
        
        // Özel hücre sınıfını kaydetme
        customerCalendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
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
        customerMonthDetailLabel.text = ""
        if self.customerStores.Stores.isEmpty {
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
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let today = Date()
        let selectedYear = Calendar.current.component(.year, from: date)
        let currentYear = Calendar.current.component(.year, from: today)
        if date >= today || selectedYear < currentYear {
            return false
        }
        return true
    }
    
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
        let today = Date()
        let selectedYear = Calendar.current.component(.year, from: date)
        let currentYear = Calendar.current.component(.year, from: today)
        if date >= today || selectedYear < currentYear {
            cell.titleLabel.textColor = UIColor.lightGray
        }
        
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
        print(daysOfWeek)
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
                cell?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                cell?.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                cell?.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            }
            
            selectedDates.append(day)
        }
        for day in daysOfWeek {
            let cell = calendar.cell(for: day, at: FSCalendarMonthPosition.previous) as? CustomCalendarCell
            if selectedDates.contains(day) {
                // If the cell was not already selected, select it and update its appearance
                cell?.isCellSelected = true
                cell?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                cell?.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                cell?.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                
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
                cell?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                cell?.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                cell?.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                
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
        if customerSwitch.isOn == true {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
            
        } else {
            self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
        }
        if !self.customerStores.Stores.isEmpty {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        else {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            self.checkChartData()
        }
        customerWeekDetailLabel.text = "\(weekOfYear). Week"
        customerWeekStackView.isHidden = true
    }
    
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        for cell in calendar.visibleCells() {
            cell.backgroundColor = UIColor.white
            calendar.setCurrentPage(calendar.currentPage, animated: false)
        }
        calendar.reloadData()
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
        self.storesTableViewHeight.constant = self.storesTableView.contentSize.height
        self.categoryTableViewHeight.constant = self.chanelTableView.contentSize.height
        if self.customerStores.Stores.count > 6 {
            self.customerViewHeight.constant = 1500
        }
    }
    @objc func refresh(sender:AnyObject) {
        if !self.customerStores.Stores.isEmpty {
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
        self.yesterdayButton.isSelected = true
        
    }
    @IBAction func DidValueChanged(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.customerLflLabel.text = "LFL"
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
            self.customerLflLabel.text = "ALL"
            
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
        
        if !self.customerStores.Stores.isEmpty {
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
                    
                    self.customerStores.Customer = json!["CustomerByStores"]?.value(forKey: "Customer") as? [String] ?? ["0"]
                    self.customerStores.FiiliCustomer = json!["CustomerByStores"]?.value(forKey: "FiiliCustomer") as? [Double] ?? [0.0]
                    self.customerStores.Stores = json!["CustomerByStores"]?.value(forKey: "Stores") as? [String] ?? ["0"]
                    self.customerStores.ColorStores = json!["CustomerByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.customerStores.Last_Update =  json!["CustomerByStores"]?.value(forKey: "Last_Update") as? [String] ?? [""]
                    self.customerStores.Gelisim =  json!["CustomerByStores"]?.value(forKey: "Gelisim") as? [String] ?? [""]
                    
                    
                    self.customerCategory.Customer = json!["CustomerByCategory"]?.value(forKey: "Customer") as? [String] ?? ["0"]
                    self.customerCategory.FiiliCustomer = json!["CustomerByCategory"]?.value(forKey: "FiiliCustomer") as? [Double] ?? [0.0]
                    self.customerCategory.CategoryBreakDown = json!["CustomerByCategory"]?.value(forKey: "CategoryBreakDown") as? [String] ?? ["0"]
                    self.customerCategory.ColorCategory = json!["CustomerByCategory"]?.value(forKey: "ColorCategory") as? [String] ?? ["0"]
                    self.customerCategory.Gelisim = json!["CustomerByCategory"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    
                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        //                        let removeCharactersLatUpdate: Set<Character> = ["T", ":"]
                        //                        self.customerStores.LastUpdate[0].removeAll(where: { removeCharactersLatUpdate.contains($0) })
                        if self.customerStores.Last_Update.isEmpty {
                            self.lastUpdateTİme.text = ""
                            
                        } else {
                            
                            self.lastUpdateTİme.text = "Last Updated Time \(self.customerStores.Last_Update[0])"
                        }
                        
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
        for i in 0..<customerStores.Stores.count {
            if self.customerStores.FiiliCustomer.isEmpty {
                entriesStores.append(PieChartDataEntry(value: 0.0 , label: ""))
                
            } else {
                entriesStores.append(PieChartDataEntry(value: Double(self.customerStores.FiiliCustomer[i]) , label: ""))
            }
        }
        for i in 0..<customerCategory.CategoryBreakDown.count {
            if self.customerCategory.FiiliCustomer.isEmpty {
                entriesChannel.append(PieChartDataEntry(value: 0.0 , label: ""))
                
            } else {
                entriesChannel.append(PieChartDataEntry(value: Double(self.customerCategory.FiiliCustomer[i]) , label: ""))
                
            }
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
        
        dataSetStores.sliceSpace = 2
        dataSetStores.drawValuesEnabled = false
        dataSetChannel.sliceSpace = 2
        dataSetChannel.drawValuesEnabled = false
        
        storesChartView.data = PieChartData(dataSet: dataSetStores)
        storesChartView.notifyDataSetChanged()
        chanelChartView.data = PieChartData(dataSet: dataSetChannel)
        chanelChartView.notifyDataSetChanged()
    }
    
    //    MARK: - Months Button Pressed
    
    @IBAction func MonthsButtonPressed(_ sender: BaseButton) {
        for i in 0..<months.count - 1 {
            if sender.titleLabel?.text ?? "" == months[i].titleLabel?.text {
                months[i].backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                months[i].tintColor = .white
                User.monthsNumber = i + 1
                customerMonthDetailLabel.text = "0\(User.monthsNumber)/2023"
                if customerSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                }
                if !self.customerStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                } else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                monthCustomerView.isHidden = true
                
            } else {
                months[i].backgroundColor = .white
                months[i].tintColor = .black
            }
        }
    }
    //    MARK: - Buttons Pressed
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        
        monthCustomerView.isHidden = true
        customerWeekStackView.isHidden = true
        let topOffset = CGPoint(x: 0, y: 0)
        scrool.setContentOffset(topOffset, animated: true)
        
        if sender.titleLabel?.text == "Weekly"{
            customerWeekStackView.isHidden = false
        }
        if sender.titleLabel?.text == "Monthly"{
            monthCustomerView.isHidden = false
            let currentDate = Date()
            let currentMonth = Calendar.current.component(.month, from: currentDate)
            for i in 0..<currentMonth  {
                if i <= currentMonth {
                    months[i].alpha = 1
                    months[i].isUserInteractionEnabled = true
                }
            }
        }
        var button = ""
        for i in 0..<buttons.count {
            if sender.titleLabel?.text == buttons[i].titleLabel?.text {
                button = buttons[i].titleLabel?.text ?? ""
                if customerSwitch.isOn == true {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    
                } else {
                    self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"WeekNumber\": 0,\"MonthNumber\": 0}"
                }
                if !self.customerStores.Stores.isEmpty {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                else {
                    hud.textLabel.text = "Loading"
                    hud.show(in: self.view)
                    self.checkChartData()
                }
                
                buttons[i].isSelected = true
                arrayView[i].backgroundColor = UIColor.white
                arrayLabel[i].textColor = UIColor(red:5/255, green:71/255, blue:153/255, alpha: 1)
            }
            else {
                buttons[i].isSelected = false
                arrayView[i].backgroundColor = UIColor.clear
                arrayLabel[i].textColor = UIColor.white
            }
        }
    }
}
extension CustomerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        if tableView == storesTableView {
            numberOfRow = self.customerStores.Stores.count
        }
        else if tableView == chanelTableView {
            numberOfRow = self.customerCategory.CategoryBreakDown.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "customerStoreCell", for: indexPath) as! CustomerStoreTableViewCell
            if self.customerStores.ColorStores.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.customerStores.ColorStores[indexPath.item]
            }
            
            if self.customerStores.Customer.count <= 1 {
                self.selectedCiro = ""
                
            } else {
                self.selectedCiro = self.customerStores.Customer[indexPath.item]
            }
            if self.customerStores.Stores.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.customerStores.Stores[indexPath.item]
            }
            if self.customerStores.Gelisim.count <= 1 {
                self.selectedStoresGelisim = ""
                
            } else {
                self.selectedStoresGelisim = self.customerStores.Gelisim[indexPath.item]
            }
            
            storeCell.prepareCell(info: selectedInfo, color: selectedColor, ciro: selectedCiro, gelisim: selectedStoresGelisim)
            
            cellToReturn = storeCell
            
            
        }  else if tableView == self.chanelTableView {
            let chanelCell = tableView.dequeueReusableCell(withIdentifier: "customerCategoryCell", for: indexPath) as! CustomerCategoryTableViewCell
            
            if self.customerCategory.ColorCategory.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.customerCategory.ColorCategory[indexPath.item]
            }
            
            if self.customerCategory.Customer.count <= 1 {
                self.selectedCiro = ""
                
            } else {
                self.selectedCiro = self.customerCategory.Customer[indexPath.item]
            }
            if self.customerCategory.CategoryBreakDown.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.customerCategory.CategoryBreakDown[indexPath.item]
            }
            if self.customerCategory.Gelisim.count <= 1 {
                self.selectedCategoryGelisim = ""
                
            } else {
                self.selectedCategoryGelisim = self.customerCategory.Gelisim[indexPath.item]
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
