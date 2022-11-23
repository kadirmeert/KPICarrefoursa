//
//  StoresTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 23.10.2022.
//

import UIKit

class StoresTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var storesLabel: UILabel!
    @IBOutlet weak var storesİmage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.innerView.dropShadow(cornerRadius: 12)
        self.storesİmage.dropShadow(cornerRadius: self.storesİmage.frame.height / 2)
        
    }
    func prepareCell(info: String, color: String) {
        
        self.storesİmage.backgroundColor = UIColor(hexString: color)
        self.storesLabel.text = "\(info)"
       
    }

}
