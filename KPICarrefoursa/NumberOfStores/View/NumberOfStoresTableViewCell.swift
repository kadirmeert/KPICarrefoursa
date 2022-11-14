//
//  NumberOfStoresTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 19.10.2022.
//

import UIKit

class NumberOfStoresTableViewCell: UITableViewCell {
    //MARK: Outlets
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var storesLabel: UILabel!
    
    //MARK: Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorView.dropShadow(cornerRadius: self.colorView.frame.height / 2)
        
    }
    
    func prepareCell(format: String, color: String,count: Bool, area: Int, city: Int) {
        
        self.colorView.backgroundColor = UIColor(hexString: color)
        if area > 1000 {
            self.storesLabel.text = "\(format) : \(Double(area) / 1000.0 )K m2 - \(city) City"
        }
        else {
            self.storesLabel.text = "\(format) : \( Double(area) / 1000.0 )K m2 - \(city) City"
        }
    }
}

