//
//  TestViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 15.03.2023.
//

import Foundation
import UIKit
import FSCalendar

class TestViewController: UIViewController,  FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance  {
    
    //    MARK: -Outlets
    @IBOutlet weak var testCalendar: FSCalendar!
    
    
    // MARK: - Properties
    var formatter = DateFormatter()
    var selectedDate: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testCalendar.delegate = self
        testCalendar.dataSource = self
        
        testCalendar.appearance.headerDateFormat = "MMMM yyyy"
        testCalendar.scope = .month
        testCalendar.scrollDirection = .horizontal
        testCalendar.placeholderType = .fillHeadTail
        
        // Ay isimlerinin rengini mavi yapalım
        testCalendar.appearance.headerTitleColor =  UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        testCalendar.appearance.headerTitleFont = UIFont(name: "Montserrat-Bold", size: 17)
        
        
        // Hafta sayısı görüntülemek için ayarlar
        testCalendar.appearance.weekdayTextColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        testCalendar.appearance.weekdayFont = UIFont(name: "Montserrat-Medium", size: 17)
        testCalendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
        testCalendar.firstWeekday = 2
        
        //       MARK: -GÜNLER
        //        testCalendar.appearance.borderRadius = 0.0
        //        testCalendar.appearance.borderDefaultColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        //        testCalendar.appearance.titleSelectionColor = .white
        testCalendar.appearance.todayColor = .clear
        testCalendar.appearance.titleSelectionColor = .black
        testCalendar.appearance.titleDefaultColor = UIColor.black
        
        
        // Özel hücre sınıfını kaydetme
        testCalendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
    }
    
    func getWeekNumber(date: Date) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // Pazartesi günü başlaması için 2 olarak ayarla
        let dateComponents = calendar.dateComponents([.weekOfYear], from: date)
        return dateComponents.weekOfYear!
    }
    //
    //    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    //        let weekday = Calendar.current.component(.weekday, from: date)
    //        return weekday == 2 // yalnızca pazartesi günleri seçilebilir olur
    //    }
    //
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
        
        //        let calendarCurrent = Calendar.current
        //        let components = calendarCurrent.dateComponents([.year, .month], from: date)
        //
        //        let thisMonth = calendarCurrent.dateComponents([.year, .month], from: Date())
        if calendar.today == date {
            return UIColor.red
        }
        return UIColor.black
    }
    
    // Hafta sayısı görüntülemek için gerekli olan iki fonksiyon
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as! CustomCalendarCell
        let weekday = Calendar.current.component(.weekday, from: date)
        let isMonday = weekday == 2
        cell.weekNumberLabel.isHidden = !isMonday // Hafta numarası etiketini sadece pazartesi günlerinde göster
        if isMonday {
            cell.weekNumber = "\(getWeekNumber(date: date))"
        }
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let cell = cell as! CustomCalendarCell
        let weekday = Calendar.current.component(.weekday, from: date)
        cell.weekNumberLabel.isHidden = weekday != 2 // Hafta numarası etiketini sadece pazartesi günlerinde göster
        if weekday == 2 {
            cell.weekNumber = "\(getWeekNumber(date: date))"
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
        print("Selected date is in week number \(getWeekNumber(date: date))")
        
        // Check if selected date is a Monday
        let weekday = Calendar.current.component(.weekday, from: date)
        
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
            let isInSameRow = Calendar.current.isDate(day, equalTo: startOfWeek, toGranularity: .weekOfYear)
            if isInSameRow, let cell = calendar.cell(for: day, at: monthPosition) as? CustomCalendarCell {
                if selectedDates.contains(day) {
                    // If the cell was already selected, deselect it and reset its appearance
                    cell.isCellSelected = false
                    cell.backgroundColor = .clear
                    cell.titleLabel.textColor = UIColor.black
                    cell.appearance.selectionColor = .clear
                } else {
                    // If the cell was not already selected, select it and update its appearance
                    cell.isCellSelected = true
                    cell.backgroundColor = UIColor.lightGray
                    cell.weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
                    cell.titleLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
//                    cell.appearance.titleSelectionColor = UIColor.red
//                    cell.appearance.eventSelectionColor = UIColor.red
                }
                
                selectedDates.append(day)
            }
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
}
