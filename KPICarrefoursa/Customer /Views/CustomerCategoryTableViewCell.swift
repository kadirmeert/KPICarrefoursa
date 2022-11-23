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
    func prepareCell(info: String, color: String, ciro: Double) {
        
        self.customerCategoryİmageView.backgroundColor = UIColor(hexString: color)
        self.customerCategoryLabel.text = "\(info): \(String(format: "%.2f", ciro / 1000.0 )) K"
       
    }


}
