//
//  ChartViewControllers.swift
//  KPICarrefoursa
//
//  Created by Mert on 16.03.2023.
//

import UIKit
import Charts

class ChartViewControllers: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Yuvarlak grafik için verileri oluşturun
        let entries = [
            PieChartDataEntry(value: 20, label: "Data 1"),
            PieChartDataEntry(value: 30, label: "Data 2"),
            PieChartDataEntry(value: 50, label: "Data 3")
        ]
        
        // Yuvarlak grafik veri setini oluşturun
        let dataSet = PieChartDataSet(entries: entries, label: "Data")
        let data = PieChartData(dataSet: dataSet)
        
        // Yuvarlak grafik görünümünü oluşturun ve verileri ekle
//        let chartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        chartView.data = data
        
        // Yuvarlak grafik görünümünü ekleyin
        view.addSubview(chartView)
        
        // Verileri göstermek için bir UILabel oluşturun ve verileri ekleyin
        let label = UILabel(frame: CGRect(x: 0, y: 220, width: 200, height: 100))
        label.numberOfLines = 0
        
        for entry in entries {
            label.text?.append("\(entry.label ?? ""): \(entry.value)\n")
        }
        
        // Veri görünümünü ekleyin
        view.addSubview(label)
    }
}
