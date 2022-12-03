//
//  PriceStoresTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class PriceStoresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var priceStoresLabel: UILabel!
    @IBOutlet weak var priceStoresİmageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.priceStoresİmageView.dropShadow(cornerRadius: self.priceStoresİmageView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, ciro: Double, gelisim: String) {
        self.priceStoresİmageView.backgroundColor = UIColor(hexString: color)
        self.priceStoresLabel.text = "\(info): \(ciro)₺   \(gelisim.components(separatedBy: [" "]).joined())"
    }

}
