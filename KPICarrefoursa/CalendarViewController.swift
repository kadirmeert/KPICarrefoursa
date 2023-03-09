//
//  CalendarViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 8.03.2023.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Takvim ayarları
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()

    // Gösterilecek tarih
    var selectedDate = Date()

    // Günlerin listesi
    var daysInMonth = [Date]()

    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // CollectionView ayarları
        collectionView.delegate = self
        collectionView.dataSource = self

        // Takvim ayarları
        dateFormatter.dateFormat = "yyyy MM dd"
        daysInMonth = getDaysInMonth(date: selectedDate)
    }

    // CollectionView Delegate & DataSource metotları

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInMonth.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let date = daysInMonth[indexPath.item]
        cell.dateLabel.text = "\(calendar.component(.day, from: date))"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: width)
    }

    // Yardımcı metotlar

    func getDaysInMonth(date: Date) -> [Date] {
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        dateComponents.day = 1
        let firstDayOfMonth = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!
        let numDays = range.count

        var days = [Date]()
        for day in 1...numDays {
            dateComponents.day = day
            let date = calendar.date(from: dateComponents)!
            days.append(date)
        }
        return days
    }

    // CollectionView hücre sınıfı
    class CalendarCell: UICollectionViewCell {
        @IBOutlet weak var dateLabel: UILabel!
    }

}

