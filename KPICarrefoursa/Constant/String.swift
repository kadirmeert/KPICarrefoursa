//
//  String.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.03.2023.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(_ bundleClass: AnyClass) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle(for: bundleClass), value: "", comment: "")
    }
}
