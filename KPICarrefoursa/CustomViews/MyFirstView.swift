//
//  MyFirstView.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.03.2023.
//

import UIKit

class MyFirstView: UIView {
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view.backgroundColor = UIColor.blue
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
        let view = Bundle.main.loadNibNamed("MyFirstView", owner: self, options: nil)?.first as? UIView
        view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view?.frame = bounds
        addSubview(view!)
        return view!
    }
}
