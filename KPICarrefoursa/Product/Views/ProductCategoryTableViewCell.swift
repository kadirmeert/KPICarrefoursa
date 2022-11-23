//
//  ProductCategoryTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class ProductCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var productCategoryİmageView: UIView!
    @IBOutlet weak var productCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productCategoryİmageView.dropShadow(cornerRadius: self.productCategoryİmageView.frame.height / 2)

    }

    func prepareCell(info: String, color: String, product: Int) {
    
            self.productCategoryİmageView.backgroundColor = UIColor(hexString: color)
        self.productCategoryLabel.text =  "\(info): \(String(format: "%.2f", Double(product) / 1000.0 )) K"
    
        }

}
