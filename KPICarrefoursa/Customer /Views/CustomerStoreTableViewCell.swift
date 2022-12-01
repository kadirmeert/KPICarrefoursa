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
    func prepareCell(info: String, color: String, ciro: String, gelisim: String) {

        self.customerStoresView.backgroundColor = UIColor(hexString: color)
//        if gelisim.components(separatedBy: ["v","s"," ","%"]).dropLast(4).joined().toDouble > 0.0 {
//            self.customerStoresLabel.text = "\(info): \(ciro)    \(gelisim.components(separatedBy: ["v"," ","s"]).dropLast(4).joined())"
//        } else {
//            self.customerStoresLabel.text = "\(info): \(ciro)    \(gelisim.components(separatedBy: ["-"," ","v","s"]).dropLast(4).joined())"
//        }

        self.customerStoresLabel.text = "\(info): \(ciro)   \(gelisim)"
       
    }


}
