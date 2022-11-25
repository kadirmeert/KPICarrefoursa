//
//  FormatTableViewCell.swift
//  KPICarrefoursa
//
//  Created by Mert on 10.11.2022.
//

import UIKit

class FormatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var formatİnnerView: UIView!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var formatİmageView: UIImageView!
    @IBOutlet weak var formatPercView: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var formatView: UIView!
    
    let removeCharacters: Set<Character> = [" ", "-"]
    override func awakeFromNib() {
        super.awakeFromNib()
        self.formatİnnerView.dropShadow(cornerRadius: 12)
        self.progressView.dropShadow(cornerRadius: 8)
        self.formatView.layer.cornerRadius = 4
        
    }
    func prepareCell(format: String, color: String, percentage: String, price: Double, gelisim: String, years: String) {
        
        
        if Double(gelisim.components(separatedBy: ["%"," ", "v", "s"]).dropLast(2).joined()) ?? 0.0 > 0.0 {
            self.formatPercView.text = gelisim.components(separatedBy: [" ", "v", "s"]).dropLast(2).joined()
            self.formatİmageView.image = UIImage(named: "Up")
            self.priceLabel.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
            self.formatPercView.textColor = UIColor(red:10/255, green:138/255, blue:33/255, alpha: 1)
        } else {
            self.formatPercView.text = gelisim.components(separatedBy: [" ", "v", "s", "-"]).dropLast(2).joined()
            self.formatİmageView.image = UIImage(named: "down")
            self.priceLabel.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
            self.formatPercView.textColor = UIColor(red:223/255, green:47/255, blue:49/255, alpha: 1)
        }
        self.yearLabel.text = years
        self.formatLabel.text = format
        
        self.priceLabel.text = "\(percentage)"
        
    
        self.progressView.setProgress((Float(gelisim.components(separatedBy: ["%"," ","v","s"]).dropLast(2).joined()) ?? 0.0) / 100, animated: false)
        self.progressView.progressTintColor = UIColor(hexString: color)
        self.progressView.backgroundColor = UIColor(hexString: color).withAlphaComponent(0.2)
        
    }
}
