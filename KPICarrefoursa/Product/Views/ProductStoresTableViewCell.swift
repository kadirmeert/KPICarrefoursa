//
//  ProductStoresTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class ProductStoresTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var productStoresİmageView: UIView!
    @IBOutlet weak var productStoresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productStoresİmageView.dropShadow(cornerRadius: self.productStoresİmageView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, product: String) {
    
            self.productStoresİmageView.backgroundColor = UIColor(hexString: color)
        self.productStoresLabel.text = "\(info): \(product)"
         
    
        }

}
