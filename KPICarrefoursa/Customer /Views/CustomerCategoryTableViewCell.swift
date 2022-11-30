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
            self.customerCategoryLabel.text = "\(info): \(ciro) # \(gelisim.components(separatedBy: ["v"," ","s"]).dropLast(4).joined())"
            self.customerCategoryLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
        } else {
            self.customerCategoryLabel.text = "\(info): \(ciro) # \(gelisim.components(separatedBy: ["-"," ","v","s"]).dropLast(4).joined())"
            self.customerCategoryLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
        }
       
    }


}
