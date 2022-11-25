//
//  ChanelTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class ChanelTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var chanelLabel: UILabel!
    @IBOutlet weak var chanelİmage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerView.dropShadow(cornerRadius: 12)
        self.chanelİmage.dropShadow(cornerRadius: self.chanelİmage.frame.height / 2)

    }
    
    func prepareCell(info: String, color: String, price: String) {
        
        self.chanelİmage.backgroundColor = UIColor(hexString: color)
        self.chanelLabel.text = "\(info): \(price)"
       
    }
    


}
