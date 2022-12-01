//
//  CustomerCategoryTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class CustomerCategoryTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var customerCategoryİmageView: UIView!
    @IBOutlet weak var customerCategoryLabel: UILabel!
    
    //MARK: Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customerCategoryİmageView.dropShadow(cornerRadius: self.customerCategoryİmageView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, ciro: String, gelisim: String) {
        
        self.customerCategoryİmageView.backgroundColor = UIColor(hexString: color)
        if gelisim.components(separatedBy: ["v","s"," ","%"]).dropLast(4).joined().toDouble > 0.0 {
            self.customerCategoryLabel.text = "\(info): \(ciro)    \(gelisim.components(separatedBy: ["v"," ","s"]).dropLast(4).joined())"
        } else {
            self.customerCategoryLabel.text = "\(info): \(ciro)    \(gelisim.components(separatedBy: ["-"," ","v","s"]).dropLast(4).joined())"
        }
       
    }


}
