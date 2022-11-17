//
//  BasketCategoryTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class BasketCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var basketCategoryLabel: UILabel!
    @IBOutlet weak var basketCategoryİmageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.basketCategoryİmageView.dropShadow(cornerRadius: self.basketCategoryİmageView.frame.height / 2)

    }
    func prepareCell(info: String, color: String, count: Bool, ciro: Double) {
        
    
        self.basketCategoryİmageView.backgroundColor = UIColor(hexString: color)
        self.basketCategoryLabel.text = "\(info): \(String(format: "%.2f", ciro / 1000.0 )) K"
    
        }

}
