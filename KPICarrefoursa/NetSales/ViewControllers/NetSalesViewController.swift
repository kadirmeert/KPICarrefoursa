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
    
    //MARK: -Properties
    
    var jsonmessage: Int = 1
    var userDC: String = ""
    var chartParameters = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    var Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    var Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    var Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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

    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.yesterdayStoreButton.isSelected = false
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            }
            
            if daytodayStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                
            }
            
            if weeklyStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                
            }
            
            if monthlyStoreButton.isSelected == true {
                
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            }
            
            if yeartodateStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.yesterdayStoreButton.isSelected = false
                
            }
            if daytodayStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            }
            if weeklyStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            }
            
            if monthlyStoreButton.isSelected == true {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Monthly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
            }
            
            if yeartodateStoreButton.isSelected == true  {
                if netSales2021Button.isSelected == true {
                    self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2021
                }
                if netSales2022BButton.isSelected == true {
                    self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022b
                }
                if netSales2022LEButton.isSelected == true {
                    self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                    self.chartParameters = self.Parameters2022LE
                }
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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
                            self.lastUpdateTİme.text = "00/00/000 00:00:00"
                            
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
                        
                        if self.netSalesCategory.CategoryBreakDown.count <= 1 {
                            self.fmcgPercLabel.text = "0.0 KTL"
                            self.fmcgProgress.percentLabelFormat = "0.0"
                            self.freshFoodPercLabel.text = "0.0 KTL"
                            self.freshFoodProgress.percentLabelFormat = "0.0"
                            self.homePercLabel.text = "0.0 KTL"
                            self.homeProgress.percentLabelFormat = "0.0"
                            self.textfilePercLabel.text = "0.0 KTL"
                            self.textileProgress.percentLabelFormat = "0.0"
                            self.electronicPercLabel.text = "0.0 KTL"
                            self.electronicProgress.percentLabelFormat = "0.0"
                            self.otherPercLabel.text = "0.0 KTL"
                            self.otherProgress.percentLabelFormat = "0.0"
                            self.foodPercLabel.text = "0.0 KTL"
                            self.foodProgress.percentLabelFormat = "0.0"
                            self.nonFoodPercLabel.text = "0.0 KTL"
                            self.nonFoodProgress.percentLabelFormat = "0.0"
                            
                        } else {
                            for index in 0..<self.netSalesCategory.CategoryBreakDown.count {
                                let removeCharactersGelisim: Set<Character> = ["%", "K", "T", "L", " ", "M", "B"]
                                self.netSalesCategory.Gelisim[index].removeAll(where: { removeCharactersGelisim.contains($0) } )
                                //                                self.netSalesCategory.Fark[index].removeAll(where: { removeCharactersGelisim.contains($0) } )
                                
                                if self.netSalesCategory.CategoryBreakDown[index] == "FMCG" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.fmcgPercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.fmcgProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "FMCG" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M","B"]).joined().toDouble >= 0.0 {
                                                
                                                self.fmcgPercLabel.text = self.netSalesCategory.Fark[index]
                                                self.fmcgİmage.image = UIImage(named: "Up")
                                                self.fmcgPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.fmcgPercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.fmcgİmage.image = UIImage(named: "down")
                                                self.fmcgPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.fmcgProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.fmcgProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.fmcgProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Fresh Food" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.freshFoodPercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.freshFoodProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Fresh Food" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.freshFoodPercLabel.text = self.netSalesCategory.Fark[index]
                                                self.freshFoodİmage.image = UIImage(named: "Up")
                                                self.freshFoodPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.freshFoodPercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.freshFoodİmage.image = UIImage(named: "down")
                                                self.freshFoodPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.freshFoodProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.freshFoodProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.freshFoodProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Home" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.homePercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.homeProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Home" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.homePercLabel.text = self.netSalesCategory.Fark[index]
                                                self.homeİmage.image = UIImage(named: "Up")
                                                self.homePercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.homePercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.homeİmage.image = UIImage(named: "down")
                                                self.homePercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.homeProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.homeProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.homeProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Textile" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.textfilePercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.textileProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Textile" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.textfilePercLabel.text = self.netSalesCategory.Fark[index]
                                                self.textfileİmage.image = UIImage(named: "Up")
                                                self.textfilePercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.textfilePercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.textfileİmage.image = UIImage(named: "down")
                                                self.textfilePercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.textileProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.textileProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.textileProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Electronic" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.electronicPercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.electronicProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Electronic" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.electronicPercLabel.text = self.netSalesCategory.Fark[index]
                                                self.electronicİmage.image = UIImage(named: "Up")
                                                self.electronicPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.electronicPercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.electronicİmage.image = UIImage(named: "down")
                                                self.electronicPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.electronicProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.electronicProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.electronicProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Other" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.otherPercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.otherProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Other" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.otherPercLabel.text = self.netSalesCategory.Fark[index]
                                                self.otherİmage.image = UIImage(named: "Up")
                                                self.otherPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.otherPercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.otherİmage.image = UIImage(named: "down")
                                                self.otherPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.otherProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.otherProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.otherProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Food" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.foodPercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.foodProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Food" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.foodPercLabel.text = self.netSalesCategory.Fark[index]
                                                self.foodİmage.image = UIImage(named: "Up")
                                                self.foodPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.foodPercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.foodİmage.image = UIImage(named: "down")
                                                self.foodPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.foodProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.foodProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.foodProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
                                            }
                                        }
                                    }
                                }
                                if self.netSalesCategory.CategoryBreakDown[index] == "Non-Food" {
                                    if self.netSalesCategory.Fark.count <= 1 {
                                        self.nonFoodPercLabel.text = "0.0 KTL"
                                        
                                    }
                                    if self.netSalesCategory.Gelisim.count <= 1 {
                                        self.nonFoodProgress.percentLabelFormat = "0.0"
                                        
                                    } else {
                                        if self.netSalesCategory.CategoryBreakDown[index] == "Non-Food" {
                                            if self.netSalesCategory.Fark[index].components(separatedBy: ["K","T","L"," ","M", "B"]).joined().toDouble >= 0.0 {
                                                
                                                self.nonFoodPercLabel.text = self.netSalesCategory.Fark[index]
                                                self.nonFoodİmage.image = UIImage(named: "Up")
                                                self.nonFoodPercLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
                                            } else {
                                                self.nonFoodPercLabel.text = self.netSalesCategory.Fark[index].components(separatedBy: ["-"]).joined()
                                                self.nonFoodİmage.image = UIImage(named: "down")
                                                self.nonFoodPercLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
                                            }
                                            self.nonFoodProgress.percentLabelFormat = "\(Double("\(self.netSalesCategory.Gelisim[index].components(separatedBy: [" "]).joined())") ?? 0.0)"
                                            if CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0 > 1.0 {
                                                self.nonFoodProgress.setProgress(progress: 1.0, animated: false)
                                            } else {
                                                self.nonFoodProgress.setProgress(progress: CGFloat((Float(self.netSalesCategory.Gelisim[index]) ?? 0.0)) / 100.0, animated: false)
                                                
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
            if sender.titleLabel?.text ?? "" == JAN.titleLabel?.text {
                JAN.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                JAN.tintColor = .white
                User.monthsNumber = 1
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
                salesMonthsView.isHidden = true
            } else {
                JAN.backgroundColor = .white
                JAN.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == FEB.titleLabel?.text {
                FEB.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                FEB.tintColor = .white
                User.monthsNumber = 2
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
                salesMonthsView.isHidden = true


            } else {
                FEB.backgroundColor = .white
                FEB.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == MAR.titleLabel?.text {
                MAR.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                MAR.tintColor = .white
                User.monthsNumber = 3
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
                salesMonthsView.isHidden = true

            } else {
                MAR.backgroundColor = .white
                MAR.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == APR.titleLabel?.text {
                APR.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                APR.tintColor = .white
                User.monthsNumber = 4
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
                salesMonthsView.isHidden = true


            } else {
                APR.backgroundColor = .white
                APR.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == MAY.titleLabel?.text {
                MAY.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                MAY.tintColor = .white
                User.monthsNumber = 5
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
                salesMonthsView.isHidden = true

            } else {
                MAY.backgroundColor = .white
                MAY.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == JUN.titleLabel?.text {
                JUN.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                JUN.tintColor = .white
                User.monthsNumber = 6
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
                salesMonthsView.isHidden = true


            } else {
                JUN.backgroundColor = .white
                JUN.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == JULY.titleLabel?.text {
                JULY.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                JULY.tintColor = .white
                User.monthsNumber = 7
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
                salesMonthsView.isHidden = true


            } else {
                JULY.backgroundColor = .white
                JULY.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == AUG.titleLabel?.text {
                AUG.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                AUG.tintColor = .white
                User.monthsNumber = 8
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
                salesMonthsView.isHidden = true


            } else {
                AUG.backgroundColor = .white
                AUG.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == SEP.titleLabel?.text {
                SEP.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                SEP.tintColor = .white
                User.monthsNumber = 9
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
                salesMonthsView.isHidden = true

            } else {
                SEP.backgroundColor = .white
                SEP.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == OCT.titleLabel?.text {
                OCT.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                OCT.tintColor = .white
                User.monthsNumber = 10
                salesMonthsDetailLabel.text = "\(User.monthsNumber)/2023"
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
                salesMonthsView.isHidden = true


            } else {
                OCT.backgroundColor = .white
                OCT.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == NOV.titleLabel?.text {
                NOV.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                NOV.tintColor = .white
                User.monthsNumber = 11
                salesMonthsDetailLabel.text = "\(User.monthsNumber)/2023"
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
                salesMonthsView.isHidden = true

            } else {
                NOV.backgroundColor = .white
                NOV.tintColor = .black
            }
            if sender.titleLabel?.text ?? "" == DEC.titleLabel?.text {
                DEC.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                DEC.tintColor = .white
                User.monthsNumber = 12
                salesMonthsDetailLabel.text = "\(User.monthsNumber)/2023"
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
                salesMonthsView.isHidden = true

                
            } else {
                DEC.backgroundColor = .white
                DEC.tintColor = .black
            }
            
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
    //                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.chartParameters = self.Parameters2021
    //                self.netSales2021Button.isSelected = false
    //
    //            }
    //            if netSales2022BButton.isSelected == true {
    //                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.chartParameters = self.Parameters2022b
    //
    //            }
    //            if netSales2022LEButton.isSelected == true {
    //                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.chartParameters = self.Parameters2022LE
    //
    //            }
    //        } else {
    //            if netSales2021Button.isSelected == true {
    //                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.chartParameters = self.Parameters2021
    //                self.netSales2021Button.isSelected = false
    //
    //            }
    //            if netSales2022BButton.isSelected == true {
    //                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
    //                self.chartParameters = self.Parameters2022b
    //            }
    //            if netSales2022LEButton.isSelected == true {
    //                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Hourly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022LE
            }
            
        } else {
            
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
            }
            
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
            }
            
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Yesterday\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022LE
                
            }
            
        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"DayToDay\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022LE
            }
            
        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"Weekly\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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
        salesMonthsView.isHidden.toggle()
        //        hourlyStoreButton.isSelected = false
        yesterdayStoreButton.isSelected = false
        daytodayStoreButton.isSelected = false
        weeklyStoreButton.isSelected = false
        monthlyStoreButton.isSelected = true
        yeartodateStoreButton.isSelected = false
       
      
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
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 1,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022LE
            }
        } else {
            if netSales2021Button.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2021
                
            }
            if netSales2022BButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.chartParameters = self.Parameters2022b
                
            }
            if netSales2022LEButton.isSelected == true {
                self.Parameters2021 = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2022\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022b = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023B\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
                self.Parameters2022LE = "{\"Language\": \"tr\",\"ProcessType\": 2,\"FilterType\": \"YTD\",\"IsLfl\": 0,\"ChartType\": \"2023LE\",\"WeekNumber\": 0,\"MonthNumber\": 1}"
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





