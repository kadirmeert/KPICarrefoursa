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

    func prepareCell(info: String, color: String, product: String, gelisim: String) {
    
            self.productCategoryİmageView.backgroundColor = UIColor(hexString: color)
        self.productCategoryLabel.text =  "\(info): \(product)   \(gelisim.components(separatedBy: [" "]).joined())"
    
        }

}
