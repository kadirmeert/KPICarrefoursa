//
//  MonthsViewController.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.03.2023.
//

import UIKit

class MonthsViewController: UIView {
    @IBOutlet weak var JAN: BaseButton!
    @IBOutlet weak var FEB: BaseButton!
    @IBOutlet weak var MAR: BaseButton!
    @IBOutlet weak var APR: BaseButton!
    @IBOutlet weak var MAY: BaseButton!
    @IBOutlet weak var JUN: BaseButton!
    @IBOutlet weak var JULY: BaseButton!
    @IBOutlet weak var AUG: BaseButton!
    @IBOutlet weak var SEP: BaseButton!
    @IBOutlet weak var OCT: BaseButton!
    @IBOutlet weak var NOV: BaseButton!
    @IBOutlet weak var DEC: BaseButton!
    
    var mainViewController = MainViewController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

     // calling of loadNib() method is not required here.
    // this initializer will call init(frame: CGRect) any how we are calling loadnib in that method.
    //for demo purpose i added in every places.
    init (labelText: String) {
        super.init(frame: .zero)
        let view = loadNib()
    }
    
    @IBAction func MonthsButtonPressed(_ sender: BaseButton) {
        if sender.titleLabel?.text ?? "" == JAN.titleLabel?.text {
            JAN.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            JAN.tintColor = .white
            User.monthsNumber = 1
        } else {
            JAN.backgroundColor = .white
            JAN.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == FEB.titleLabel?.text {
            FEB.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            FEB.tintColor = .white
            User.monthsNumber = 2

        } else {
            FEB.backgroundColor = .white
            FEB.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == MAR.titleLabel?.text {
            MAR.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            MAR.tintColor = .white
            User.monthsNumber = 3

        } else {
            MAR.backgroundColor = .white
            MAR.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == APR.titleLabel?.text {
            APR.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            APR.tintColor = .white
            User.monthsNumber = 4

        } else {
            APR.backgroundColor = .white
            APR.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == MAY.titleLabel?.text {
            MAY.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            MAY.tintColor = .white
            User.monthsNumber = 5

        } else {
            MAY.backgroundColor = .white
            MAY.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == JUN.titleLabel?.text {
            JUN.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            JUN.tintColor = .white
            User.monthsNumber = 6

        } else {
            JUN.backgroundColor = .white
            JUN.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == JULY.titleLabel?.text {
            JULY.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            JULY.tintColor = .white
            User.monthsNumber = 7

        } else {
            JULY.backgroundColor = .white
            JULY.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == AUG.titleLabel?.text {
            AUG.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            AUG.tintColor = .white
            User.monthsNumber = 8

        } else {
            AUG.backgroundColor = .white
            AUG.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == SEP.titleLabel?.text {
            SEP.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            SEP.tintColor = .white
            User.monthsNumber = 9

        } else {
            SEP.backgroundColor = .white
            SEP.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == NOV.titleLabel?.text {
            NOV.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            NOV.tintColor = .white
            User.monthsNumber = 10

        } else {
            NOV.backgroundColor = .white
            NOV.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == OCT.titleLabel?.text {
            OCT.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            OCT.tintColor = .white
            User.monthsNumber = 11

        } else {
            OCT.backgroundColor = .white
            OCT.tintColor = .black
        }
        if sender.titleLabel?.text ?? "" == DEC.titleLabel?.text {
            DEC.backgroundColor = UIColor(red:0/255, green:71/255, blue:152/255, alpha: 1)
            DEC.tintColor = .white
            User.monthsNumber = 12

        } else {
            DEC.backgroundColor = .white
            DEC.tintColor = .black
        }
        
    }
    
    // If you embed the view in parent view, this method will call
    //here we are added class name to file owner so called load() method here.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = loadNib()
    }

    @discardableResult func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed("MonthsViewController", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        return view!
    }
}
