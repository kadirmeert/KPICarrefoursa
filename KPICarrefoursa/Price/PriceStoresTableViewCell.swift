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
    func prepareCell(info: String, color: String, count: Bool, ciro: Double) {
        self.priceStoresİmageView.backgroundColor = UIColor(hexString: color)
        self.priceStoresLabel.text = "\(info): \(String(format: "%.2f", ciro / 1000.0 )) K"

    }

}
