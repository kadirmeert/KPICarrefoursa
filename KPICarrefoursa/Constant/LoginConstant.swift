//
//  LoginConstant.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import Foundation

struct LoginConstants {
    
    static var xApiKey = "DdTQR9hNaFE77XNsh05Px0rc94Vve9KK"
    static var IV = "80prtJez2Mi3TOeZ"
    static var headers = [
        "X-API-KEY": "\(LoginConstants.xApiKey)",
        "X-IV-KEY": "\(LoginConstants.IV)",
        "Content-Type": "application/json",
        "Authorization": "Bearer \(User.JWT)"
        
    ]
}
