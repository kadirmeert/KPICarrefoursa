//
//  SalesTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 18.11.2022.
//

import UIKit

class SalesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var salesİnnerView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var salesimageView: UIImageView!
    @IBOutlet weak var salesPercentageLabel: UILabel!
    @IBOutlet weak var salesPriceLabel: UILabel!
    @IBOutlet weak var salesView: UIView!
    @IBOutlet weak var salesProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.salesİnnerView.dropShadow(cornerRadius: 12)
        self.salesProgressView.dropShadow(cornerRadius: 8)
        self.salesView.layer.cornerRadius = 4
    }

   

}
