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
import FSCalendar

class NetSalesViewController: UIViewController, ChartViewDelegate,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //MARK: -Outlets
    
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
    @IBOutlet weak var salesMonthsView: UIView!
    @IBOutlet weak var salesMonthsStackView: UIStackView!
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
    @IBOutlet weak var salesMonthsDetailLabel: UILabel!
    @IBOutlet weak var salesWeekStackView: UIStackView!
    @IBOutlet weak var salesCalendar: FSCalendar!
    @IBOutlet weak var salesWeekDetailLabel: UILabel!
    
    
    
    //MARK: -Properties
    var months : [BaseButton] = []
    var buttons : [UIButton] = []
    var arrayView : [UIView] = []
    var arrayLabel : [UILabel] = []
    var categorylabel : [UILabel] = []
    var categoryİmage : [UIImageView] = []
    var categoryProgress : [MKMagneticProgress] = []
    
    var categoryArray : [String] = ["Textile", "Home", "Non-Food", "Fresh Food", "FMCG", "Food", "Electronic" , "Other" ]
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
    var Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
    var Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
    var Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
    var netSalesCiro = Ciro()
    var netSalesStores = Stores()
    var netSalesChannel = Channel()
    var netSalesFormat = Format()
    var netSalesCategory = Category()
    var hud = JGProgressHUD()
    let refreshControl = UIRefreshControl()
    var years = "2022"
    let removeCharacters: Set<Character> = ["v", "s", "%", "K", "T", "L", " ", "B", "E"]
    var selectedColor = ""
    var selectedInfo = ""
    var selectedPrice = ""
    var selectedFormat = ""
    var isPrice = 0.0
    var isprogress = ""
    var isGelisim = ""
    var selectedStoresGelisim = ""
    var selectedChanelGelisim = ""
    var formatter = DateFormatter()
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryProgress.append(textileProgress);  categoryProgress.append(homeProgress) ;  categoryProgress.append(nonFoodProgress) ;  categoryProgress.append(freshFoodProgress) ;  categoryProgress.append(fmcgProgress) ;  categoryProgress.append(foodProgress) ; categoryProgress.append(electronicProgress) ; categoryProgress.append(otherProgress)
        
        categoryİmage.append(textfileİmage);  categoryİmage.append(homeİmage) ;  categoryİmage.append(nonFoodİmage) ;  categoryİmage.append(freshFoodİmage) ;  categoryİmage.append(fmcgİmage) ;  categoryİmage.append(foodİmage) ; categoryİmage.append(electronicİmage) ; categoryİmage.append(otherİmage)
        
        categorylabel.append(textfilePercLabel);  categorylabel.append(homePercLabel) ;  categorylabel.append(nonFoodPercLabel) ;  categorylabel.append(freshFoodPercLabel) ;  categorylabel.append(fmcgPercLabel) ;  categorylabel.append(foodPercLabel) ; categorylabel.append(electronicPercLabel) ; categorylabel.append(otherPercLabel)
        
        arrayLabel.append(yesterdayStoreLabel) ;  arrayLabel.append(daytodayStoreLabel) ;  arrayLabel.append(weeklyStoreLabel) ;  arrayLabel.append(monthlyStoreLabel) ;  arrayLabel.append(yeartodateStoreLabel)
        
        arrayView.append(yesterdayStoreView) ;  arrayView.append(daytodayStoreView) ;  arrayView.append(weeklyStoreView) ;  arrayView.append(monthlyStoreView) ;  arrayView.append(yeartodateStoreView)
        
        buttons.append(yesterdayStoreButton) ;  buttons.append(daytodayStoreButton) ;  buttons.append(weeklyStoreButton) ;  buttons.append(monthlyStoreButton) ;  buttons.append(yeartodateStoreButton)
        
        months.append(JAN) ;  months.append(FEB) ;  months.append(MAR) ;  months.append(APR) ;  months.append(MAY) ;  months.append(JUN) ; months.append(JULY) ; months.append(AUG) ;  months.append(SEP) ;  months.append(OCT) ;  months.append(NOV) ;  months.append(DEC)
        for i in 0..<months.count {
            months[i].alpha = 0.5
            months[i].isUserInteractionEnabled = false
        }
        salesWeekDetailLabel.text = ""
        //  MARK: - Calendar
        salesCalendar.delegate = self
        salesCalendar.dataSource = self
        
        salesCalendar.appearance.headerDateFormat = "MMMM yyyy"
        salesCalendar.scope = .month
        salesCalendar.scrollDirection = .horizontal
        salesCalendar.placeholderType = .fillHeadTail
        
        // Ay isimlerinin rengini mavi yapalım
        salesCalendar.appearance.headerTitleColor =  UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        salesCalendar.appearance.headerTitleFont = UIFont(name: "Montserrat-Bold", size: 17)
        
        
        // Hafta sayısı görüntülemek için ayarlar
        salesCalendar.appearance.weekdayTextColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        salesCalendar.appearance.weekdayFont = UIFont(name: "Montserrat-Medium", size: 17)
        salesCalendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
        salesCalendar.firstWeekday = 2
        
        //       MARK: -GÜNLER
        salesCalendar.appearance.todayColor = .clear
        salesCalendar.appearance.titleSelectionColor = .black
        salesCalendar.appearance.titleDefaultColor = UIColor.black
        
        // Özel hücre sınıfını kaydetme
        salesCalendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
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
        prepareUI()
        salesMonthsDetailLabel.text = ""
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
        if netSalesSwitch.isOn == true {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.chartParameters = self.Parameters2022LE
            }
            
        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
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
        salesWeekDetailLabel.text = "\(weekOfYear). Week"
        salesWeekStackView.isHidden = true
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
            //                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //            }
            self.yesterdayStoreButton.isSelected = true
            if yesterdayStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.yesterdayStoreButton.isSelected = false
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
            
            if daytodayStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                
            }
            
            if weeklyStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                
            }
            
            if monthlyStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
            }
            
            if yeartodateStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
        }
        else{
            self.netSalesLflLabel.text = "ALL"
            //            if hourlyStoreButton.isSelected == true {
            //                self.chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            //            }
            self.yesterdayStoreButton.isSelected = true
            if yesterdayStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.yesterdayStoreButton.isSelected = false
                
            }
            if daytodayStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
            }
            if weeklyStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": \(User.weekNumber),\"MonthNumber\": 0}"
            }
            
            if monthlyStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
            }
            
            if yeartodateStoreButton.isSelected == true  {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
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
        if self.netSalesFormat.Gelisim.count >= 6 {
            self.netSalesHeight.constant = 3500
        }
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self.userDC)!
        let decrypted = try! AES(key: key.bytes, blockMode:CBC(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
    }
    
    func checkNetSales() {
        print(chartParameters)
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
                if json!["Success"] as? Int ?? 0 ==  0 {
                    print("error")
                } else if json!["Success"] as? Int ?? 0 == 1 {
                    
                    //                    self.netSalesCiro.Ciro = json!["NetSalesTurnover"]?.value(forKey: "Ciro") as? [String] ?? ["0"]
                    self.netSalesCiro.Gelisim = json!["NetSalesTurnover"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    self.netSalesCiro.Last_Update =  json!["NetSalesTurnover"]?.value(forKey: "Last_Update") as? [String] ?? ["0"]
                    self.netSalesCiro.Total =  json!["NetSalesTurnover"]?.value(forKey: "Total") as? [String] ?? ["0"]
                    self.netSalesCiro.Fark =  json!["NetSalesTurnover"]?.value(forKey: "Fark") as? [String] ?? ["0"]
                    self.netSalesCiro.ChartType = json!["NetSalesTurnover"]?.value(forKey: "ChartType") as? [String] ?? ["0"]
                    
                    self.netSalesStores.Ciro = json!["NetSalesByStores"]?.value(forKey: "Ciro") as? [String] ?? ["0"]
                    self.netSalesStores.FiiliCiro = json!["NetSalesByStores"]?.value(forKey: "FiiliCiro") as? [Double] ?? [0.0]
                    self.netSalesStores.ColorStores = json!["NetSalesByStores"]?.value(forKey: "ColorStores") as? [String] ?? ["0"]
                    self.netSalesStores.Stores = json!["NetSalesByStores"]?.value(forKey: "Stores") as? [String] ?? ["0"]
                    self.netSalesStores.Last_Update = json!["NetSalesByStores"]?.value(forKey: "Last_Update") as? [String] ?? ["0"]
                    self.netSalesStores.Gelisim = json!["NetSalesByStores"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    
                    
                    self.netSalesChannel.FormatPNL = json!["NetSalesByChannel"]?.value(forKey: "FormatPNL") as? [String] ?? ["0"]
                    self.netSalesChannel.FiiliCiro = json!["NetSalesByChannel"]?.value(forKey: "FiiliCiro") as? [String] ?? ["0"]
                    self.netSalesChannel.Ciro = json!["NetSalesByChannel"]?.value(forKey: "Ciro") as? [String] ?? ["0"]
                    self.netSalesChannel.ColorChannels = json!["NetSalesByChannel"]?.value(forKey: "ColorChannels") as? [String] ?? ["0"]
                    self.netSalesChannel.Last_Update =  json!["NetSalesByChannel"]?.value(forKey: "Last_Update") as? [String] ?? ["0"]
                    self.netSalesChannel.Gelisim =  json!["NetSalesByChannel"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    
                    
                    self.netSalesFormat.Fark = json!["NetSalesByFormat"]?.value(forKey: "Fark") as? [String] ?? ["0"]
                    self.netSalesFormat.RevizeFormat = json!["NetSalesByFormat"]?.value(forKey: "RevizeFormat") as? [String] ?? ["0"]
                    self.netSalesFormat.Gelisim = json!["NetSalesByFormat"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    self.netSalesFormat.ColorFormat = json!["NetSalesByFormat"]?.value(forKey: "ColorFormat") as? [String] ?? ["0"]
                    
                    self.netSalesCategory.Fark = json!["NetSalesByCategory"]?.value(forKey: "Fark") as? [String] ?? ["0"]
                    self.netSalesCategory.CategoryBreakDown = json!["NetSalesByCategory"]?.value(forKey: "CategoryBreakDown") as? [String] ?? ["0"]
                    self.netSalesCategory.Gelisim = json!["NetSalesByCategory"]?.value(forKey: "Gelisim") as? [String] ?? ["0"]
                    
                    
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        
                        if self.netSalesCiro.Total.isEmpty {
                            self.totalPrice.text = "Actual CSA Total 0 MTL"
                            
                        } else {
                            self.totalPrice.text = self.netSalesCiro.Total[0]
                        }
                        
                        if self.netSalesStores.Last_Update.isEmpty {
                            self.lastUpdateTİme.text = ""
                            
                        } else {
                            self.lastUpdateTİme.text = "Last Updated Time \(self.netSalesStores.Last_Update[0])"
                        }
                        
                        
                        
                        if self.netSalesCiro.ChartType.count < 1 {
                            self.MTL2021.text = "0"
                            self.MTL2022B.text = "0"
                            self.MTL2022LE.text = "0"
                            self.percentage2021.text = "0"
                            self.percentage2022B.text = "0"
                            self.percentage2022LE.text = "0"
                            self.progress2021.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2021.setProgress(0.0, animated: false)
                            self.progress2022B.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2022B.setProgress(0.0, animated: false)
                            self.progress2022LE.transform = CGAffineTransformMakeScale(1, 1)
                            self.progress2022LE.setProgress(0.0, animated: false)
                            
                        } else {
                            
                            for i in 0..<self.netSalesCiro.Fark.count {
                                let removeCharacters: Set<Character> = ["v", "s", " ", "%", "B"]
                                self.netSalesCiro.Gelisim[i].removeAll(where: { removeCharacters.contains($0) } )
                                if self.netSalesCiro.ChartType[i] == "2022" {
                                    
                                    if self.netSalesCiro.Gelisim.count < 1 {
                                        self.percentage2021.text = "0"
                                        self.progress2021.transform = CGAffineTransformMakeScale(1, 1)
                                        self.progress2021.setProgress(0.0, animated: false)
                                        
                                    }
                                    if self.netSalesCiro.Fark.count < 1 {
                                        self.MTL2021.text = "0"
                                        
                                    } else {
                                        if Double(self.netSalesCiro.Gelisim[i].dropLast(2)) ?? 0 >= 0.0 {
                                            
                                            self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[i])"
                                            self.MTL2021.text = "\(self.netSalesCiro.Fark[i])"
                                            
                                            
                                            self.sales2021İmage.image = UIImage(named: "Up")
                                            self.MTL2021.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            self.percentage2021.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            
                                        } else {
                                            self.percentage2021.text = "% \(self.netSalesCiro.Gelisim[i].components(separatedBy: [" ", "-"]).joined())"
                                            self.MTL2021.text = "\(self.netSalesCiro.Fark[i].components(separatedBy: [" ", "-"]).joined())"
                                            self.sales2021İmage.image = UIImage(named: "down")
                                            self.MTL2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            self.percentage2021.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                        }
                                        self.progress2021.transform = CGAffineTransformMakeScale(1, 1)
                                        self.progress2021.setProgress((Float(self.netSalesCiro.Gelisim[i].dropLast(2)) ?? 0.0) / 100, animated: false)
                                    }
                                }
                                
                                if self.netSalesCiro.ChartType[i] == "2023B" {
                                    if self.netSalesCiro.Gelisim.count < 1 {
                                        self.percentage2022B.text = "0"
                                        self.progress2022B.transform = CGAffineTransformMakeScale(1, 1)
                                        self.progress2022B.setProgress(0.0, animated: false)
                                        
                                    }
                                    if self.netSalesCiro.Fark.count < 1 {
                                        self.MTL2022B.text = "0"
                                        
                                    } else {
                                        if Double(self.netSalesCiro.Gelisim[i].dropLast(2)) ?? 0 >= 0.0 {
                                            self.percentage2022B.text = "% \(self.netSalesCiro.Gelisim[i])"
                                            
                                            
                                            self.MTL2022B.text = "\(self.netSalesCiro.Fark[i])"
                                            
                                            
                                            self.sales2022Bİmage.image = UIImage(named: "Up")
                                            self.MTL2022B.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            self.percentage2022B.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            
                                        } else {
                                            self.percentage2022B.text = "% \(self.netSalesCiro.Gelisim[i].components(separatedBy: [" ", "-"]).joined())"
                                            self.MTL2022B.text = "\(self.netSalesCiro.Fark[i].components(separatedBy: [" ", "-"]).joined())"
                                            self.sales2022Bİmage.image = UIImage(named: "down")
                                            self.MTL2022B.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            self.percentage2022B.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                        }
                                        self.progress2022B.transform = CGAffineTransformMakeScale(1, 1)
                                        self.progress2022B.setProgress((Float(self.netSalesCiro.Gelisim[i].dropLast(2)) ?? 0.0) / 100, animated: false)
                                    }
                                }
                                if self.netSalesCiro.ChartType[i] == "2023L" {
                                    if self.netSalesCiro.Gelisim.count <= 1 {
                                        self.percentage2022LE.text = "0"
                                        self.progress2022LE.transform = CGAffineTransformMakeScale(1, 1)
                                        self.progress2022LE.setProgress(0.0, animated: false)
                                    }
                                    if self.netSalesCiro.Fark.count < 1 {
                                        self.MTL2022LE.text = "0"
                                        
                                    } else {
                                        if Double(self.netSalesCiro.Gelisim[i].dropLast(2)) ?? 0 >= 0.0 {
                                            
                                            self.percentage2022LE.text = "% \(self.netSalesCiro.Gelisim[i])"
                                            
                                            
                                            self.MTL2022LE.text = "\(self.netSalesCiro.Fark[i])"
                                            
                                            self.sales2022LEimage.image = UIImage(named: "Up")
                                            self.MTL2022LE.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            self.percentage2022LE.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            
                                        } else {
                                            if self.netSalesCiro.Gelisim.count <= 1 {
                                                self.percentage2022LE.text = "0.0"
                                            } else {
                                                self.percentage2022LE.text = "% \(self.netSalesCiro.Gelisim[i].components(separatedBy: [" ", "-"]).joined())"
                                                
                                            }
                                            if self.netSalesCiro.Fark.count <= 1 {
                                                self.MTL2022LE.text = "0"
                                            } else {
                                                self.MTL2022LE.text = "\(self.netSalesCiro.Fark[i].components(separatedBy: [" ", "-"]).joined())"
                                                
                                            }
                                            self.sales2022LEimage.image = UIImage(named: "down")
                                            self.MTL2022LE.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            self.percentage2022LE.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            
                                        }
                                        self.progress2022LE.transform = CGAffineTransformMakeScale(1, 1)
                                        self.progress2022LE.setProgress((Float(self.netSalesCiro.Gelisim[i].dropLast(2)) ?? 0.0) / 100, animated: false)
                                        
                                    }
                                }
                            }
                        }
                        
                        //MARK: -CATEGORY
                        for index in 0..<self.netSalesCategory.CategoryBreakDown.count {
                            if self.netSalesCategory.CategoryBreakDown.count <= 1 {
                                self.categorylabel[index].text = "0.0 KTL"
                                self.categoryProgress[index].percentLabelFormat = "0.0"
                            } else {
                                let removeCharactersGelisim: Set<Character> = ["%", "K", "T", "L", " ", "M", "B"]
                                self.netSalesCategory.Gelisim[index].removeAll(where: { removeCharactersGelisim.contains($0) } )
                                
                                if self.netSalesCategory.CategoryBreakDown[index] == self.categoryArray[index] {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.categorylabel[index].text = "0.0 KTL"
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.categoryProgress[index].percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == self.categoryArray[index] {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M","B"]).joined().toDouble >= 0.0 {
                                                
                                                self.categorylabel[index].text = self.netSalesCategory.Fark[index]
                                                self.categoryİmage[index].image = UIImage(named: "Up")
                                                self.categorylabel[index].textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.categorylabel[index].text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.categoryİmage[index].image = UIImage(named: "down")
                                                self.categorylabel[index].textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.categoryProgress[index].percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.categoryProgress[index].setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.categoryProgress[index].setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                    }
                                }
                            }
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
        for i in 0..<netSalesStores.FiiliCiro.count {
            entriesStores.append(PieChartDataEntry(value: Double(netSalesStores.FiiliCiro[i]), label: "" ))
        }
        for i in 0..<netSalesChannel.FiiliCiro.count {
            entriesChannel.append(PieChartDataEntry(value: Double(netSalesChannel.FiiliCiro[i]) ?? 0.0, label: "" ))
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
    //    MARK: - Months Button Pressed
    
    @IBAction func MonthsButtonPressed(_ sender: BaseButton) {
        for i in 0..<months.count - 1 {
            if sender.titleLabel?.text ?? "" == months[i].titleLabel?.text {
                months[i].backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                months[i].tintColor = .white
                User.monthsNumber = i + 1
                salesMonthsDetailLabel.text = "0\(User.monthsNumber)/2023"
                if netSalesSwitch.isOn == true {
                    if netSales2021Button.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.chartParameters = self.Parameters2021
                        
                    }
                    if netSales2022BButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.chartParameters = self.Parameters2022b
                        
                    }
                    if netSales2022LEButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.chartParameters = self.Parameters2022LE
                    }
                } else {
                    if netSales2021Button.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.chartParameters = self.Parameters2021
                        
                    }
                    if netSales2022BButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.chartParameters = self.Parameters2022b
                        
                    }
                    if netSales2022LEButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": \(User.monthsNumber)}"
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
                salesMonthsStackView.isHidden = true
                salesMonthsView.isHidden = true
            } else {
                months[i].backgroundColor = .white
                months[i].tintColor = .black
            }
        }
    }
    //    MARK: - Buttons Pressed
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        salesMonthsView.isHidden = true
        salesMonthsStackView.isHidden = true
        salesWeekStackView.isHidden = true
        
        if sender.titleLabel?.text == "Weekly"{
            salesWeekStackView.isHidden = false
            let topOffset = CGPoint(x: 0, y: 0)
            scrool.setContentOffset(topOffset, animated: true)
        }
        if sender.titleLabel?.text == "Monthly"{
            salesMonthsStackView.isHidden = false
            salesMonthsView.isHidden = false
            let topOffset = CGPoint(x: 0, y: 0)
            scrool.setContentOffset(topOffset, animated: true)
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
                if netSalesSwitch.isOn == true {
                    if netSales2021Button.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.chartParameters = self.Parameters2021
                    }
                    if netSales2022BButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.chartParameters = self.Parameters2022b
                        
                    }
                    if netSales2022LEButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.chartParameters = self.Parameters2022LE
                    }
                    
                } else {
                    
                    if netSales2021Button.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.chartParameters = self.Parameters2021
                    }
                    
                    if netSales2022BButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.chartParameters = self.Parameters2022b
                    }
                    
                    if netSales2022LEButton.isSelected == true {
                        self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
                        self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"\(button)\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 0}"
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
    
    
    @IBAction func netSales2021BtnPressed(_ sender: UIButton) {
        self.years = "2022"
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
        self.netSales2021View.backgroundColor = UIColor.white
        self.netSales2021Label.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
        self.netSales2022BView.backgroundColor = UIColor.clear
        self.netSales2022BLabel.textColor = UIColor.white
        self.netSales2022LEView.backgroundColor = UIColor.clear
        self.netSales2022LELabel.textColor = UIColor.white
    }
    
    @IBAction func netSales2022BBtnPressed(_ sender: Any) {
        self.years = "2023B"
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
        self.years = "2023LE"
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
            numberOfRow = self.netSalesStores.FiiliCiro.count
        }
        else if tableView == chanelTableView {
            numberOfRow = self.netSalesChannel.FiiliCiro.count
        }
        else if tableView == formatTableView {
            numberOfRow = self.netSalesFormat.RevizeFormat.count
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        
        if tableView == self.storesTableView {
            let storeCell = tableView.dequeueReusableCell(withIdentifier: "netSalesStoresCell", for: indexPath) as! StoresTableViewCell
            
            if self.netSalesStores.ColorStores.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.netSalesStores.ColorStores[indexPath.item]
            }
            
            if self.netSalesStores.Ciro.count <= 1 {
                self.selectedPrice = ""
                
            } else {
                self.selectedPrice = self.netSalesStores.Ciro[indexPath.item]
            }
            
            if self.netSalesStores.Stores.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.netSalesStores.Stores[indexPath.item]
            }
            if self.netSalesStores.Gelisim.count <= 1 {
                self.selectedStoresGelisim = ""
                
            } else {
                self.selectedStoresGelisim = self.netSalesStores.Gelisim[indexPath.item]
            }
            storeCell.prepareCell(info: selectedInfo , color: selectedColor, price: selectedPrice, gelisim: selectedStoresGelisim)
            
            cellToReturn = storeCell
            
            
        }  else if tableView == self.chanelTableView {
            let chanelCell = tableView.dequeueReusableCell(withIdentifier: "netSalesChanelCell", for: indexPath) as! ChanelTableViewCell
            
            if self.netSalesChannel.ColorChannels.count <= 1 {
                self.selectedColor = ""
                
            } else {
                self.selectedColor = self.netSalesChannel.ColorChannels[indexPath.item]
            }
            
            if self.netSalesChannel.Ciro.count <= 1 {
                self.selectedPrice = ""
                
            } else {
                self.selectedPrice = self.netSalesChannel.Ciro[indexPath.item]
            }
            
            if self.netSalesChannel.FormatPNL.count <= 1 {
                self.selectedInfo = ""
                
            } else {
                self.selectedInfo = self.netSalesChannel.FormatPNL[indexPath.item]
            }
            if self.netSalesChannel.Gelisim.count <= 1 {
                self.selectedChanelGelisim = ""
                
            } else {
                self.selectedChanelGelisim = self.netSalesChannel.Gelisim[indexPath.item]
            }
            
            chanelCell.prepareCell(info: selectedInfo, color: selectedColor, price: selectedPrice, gelisim: selectedChanelGelisim)
            
            cellToReturn = chanelCell
            
        } else if tableView == self.formatTableView {
            let formatCell = tableView.dequeueReusableCell(withIdentifier: "netSalesFormatCell", for: indexPath) as! FormatTableViewCell
            
            if self.netSalesFormat.ColorFormat.count <= 1 {
                self.selectedColor = ""
            } else {
                self.selectedColor = self.netSalesFormat.ColorFormat[indexPath.item]
            }
            
            if  self.netSalesFormat.RevizeFormat.count <= 1 {
                self.selectedFormat = ""
                
            } else {
                self.selectedFormat = self.netSalesFormat.RevizeFormat[indexPath.item]
            }
            
            if self.netSalesFormat.Fark.count <= 1 {
                self.isprogress = ""
                
            } else {
                self.isprogress = self.netSalesFormat.Fark[indexPath.item]
                
            }
            
            if self.netSalesFormat.Gelisim.count <= 1 {
                self.isGelisim = ""
                
            } else {
                self.isGelisim = self.netSalesFormat.Gelisim[indexPath.item]
                
            }
            
            let years = self.years
            formatCell.prepareCell(format: selectedFormat, color: selectedColor, percentage: isprogress, gelisim: isGelisim, years: years)
            
            
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





