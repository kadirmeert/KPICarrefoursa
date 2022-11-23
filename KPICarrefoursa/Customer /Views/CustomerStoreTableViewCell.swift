//
//  CustomerStoreTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class CustomerStoreTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var customerStoresLabel: UILabel!
    @IBOutlet weak var customerStoresView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customerStoresView.dropShadow(cornerRadius: self.customerStoresView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, ciro: Double) {

        self.customerStoresView.backgroundColor = UIColor(hexString: color)
        self.customerStoresLabel.text = "\(info): \(String(format: "%.2f", ciro / 1000.0 )) K"
       
    }


}
