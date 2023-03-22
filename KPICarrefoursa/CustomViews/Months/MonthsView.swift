//
//  MonthsView.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.03.2023.
//

import UIKit


class MonthsView: UIView {
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
    
    @IBOutlet var contentView: UIView!
    
    
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
        view.backgroundColor = UIColor.green
    }

    // If you embed the view in parent view, this method will call
    //here we are added class name to file owner so called load() method here.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let view = loadNib()
        view.backgroundColor = UIColor.red
    }

    @discardableResult func loadNib() -> UIView {
        let view = Bundle.main.loadNibNamed("MonthsView", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        return view!
    }
}
