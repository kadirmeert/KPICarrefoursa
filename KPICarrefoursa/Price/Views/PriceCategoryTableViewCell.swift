//
//  PriceCategoryTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class PriceCategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var priceCategoryLabel: UILabel!
    @IBOutlet weak var priceCategoryİmageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.priceCategoryİmageView.dropShadow(cornerRadius: self.priceCategoryİmageView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, ciro: Double, gelisim: String) {

        self.priceCategoryİmageView.backgroundColor = UIColor(hexString: color)
        self.priceCategoryLabel.text = "\(info): \(ciro)₺   \(gelisim.components(separatedBy: [" "]).joined())"

    }

}
