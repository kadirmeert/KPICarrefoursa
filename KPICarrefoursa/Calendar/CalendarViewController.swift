//
//  CalendarViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 13.03.2023.
//

import Foundation
import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.headerDateFormat = "MMMM yyyy"
        
        // Takvimin ayarları
//        calendar.appearance.selectionColor = UIColor.blue
//        calendar.appearance.todaySelectionColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
//        calendar.appearance.todayColor = UIColor.red
        
        // Ay isimlerinin rengini kırmızı yapalım
        calendar.appearance.headerTitleColor =  UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        calendar.appearance.headerTitleFont = UIFont(name: "Montserrat-Bold", size: 17)

        
        // Hafta sayısı görüntülemek için ayarlar
        calendar.appearance.weekdayTextColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
        calendar.appearance.weekdayFont = UIFont(name: "Montserrat-Medium", size: 17)
        calendar.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
        calendar.firstWeekday = 2
        
        // Özel hücre sınıfını kaydetme
        calendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
//        calendar.appearance.eventDefaultColor = UIColor.clear
//        calendar.appearance.eventSelectionColor = UIColor.clear
        
     
    }
    
    func getWeekNumber(date: Date) -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // Pazartesi günü başlaması için 2 olarak ayarla
        let dateComponents = calendar.dateComponents([.weekOfYear], from: date)
        return "\(dateComponents.weekOfYear!)"
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            let weekday = Calendar.current.component(.weekday, from: date)
            return weekday == 2 // Pazartesi günleri seçilebilir olsun
        }
  
    
    // Hafta sayısı görüntülemek için gerekli olan iki fonksiyon
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as! CustomCalendarCell
        let weekday = Calendar.current.component(.weekday, from: date)
        let isMonday = weekday == 2
        cell.weekNumberLabel.isHidden = !isMonday // Hafta numarası etiketini sadece pazartesi günlerinde göster
        if isMonday {
            cell.weekNumber = getWeekNumber(date: date)
        }
        return cell
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let cell = cell as! CustomCalendarCell
        let weekday = Calendar.current.component(.weekday, from: date)
        cell.weekNumberLabel.isHidden = weekday != 2 // Hafta numarası etiketini sadece pazartesi günlerinde göster
        if weekday == 2 {
            cell.weekNumber = getWeekNumber(date: date)
        }
    }

 
    
    // Özel hücre sınıfı
    class CustomCalendarCell: FSCalendarCell {

        var weekNumberLabel: UILabel!

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
            weekNumberLabel.textColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1) // mavi renk
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



