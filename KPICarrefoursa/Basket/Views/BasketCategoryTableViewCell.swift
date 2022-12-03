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
    func prepareCell(info: String, color: String, ciro: String, gelisim: String) {
        
    
        self.basketCategoryİmageView.backgroundColor = UIColor(hexString: color)
        self.basketCategoryLabel.text = "\(info): \(ciro)₺   \(gelisim.components(separatedBy: [" "]).joined())"
    
        }

}
