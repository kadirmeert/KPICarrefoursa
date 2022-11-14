//
//  BasketStoresTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class BasketStoresTableViewCell: UITableViewCell {

    @IBOutlet weak var basketStoresLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var basketStoresİmageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.basketStoresİmageView.dropShadow(cornerRadius: self.basketStoresİmageView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, count: Bool, ciro: Double) {
    
            self.basketStoresİmageView.backgroundColor = UIColor(hexString: color)
        self.basketStoresLabel.text = "\(info): \(String(format: "%.2f", ciro / 1000.0 )) K"
    
        }
    
}
