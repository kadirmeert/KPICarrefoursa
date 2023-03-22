//
//  User.swift
//  KPICarrefoursa
//
//  Created by Mert on 5.10.2022.
//

import Foundation
import UIKit

struct User {
    
    static var username = ""
    static var password = ""
    static var jsonmessage = 1
    static var JWT = ""
    static var mobilJWT = ""
    static var SmsCode = ""
    static var CodeId = 0
    static var phoneNumber = ""
    static var otp = ""
    static var Area: Array = [Int]()
    static var City: Array = [Int]()
    static var Color: Array = [String]()
    static var FilterType: Array = [String]()
    static var Format: Array = [String]()
    static var LastUpdate: Array = [String]()
    static var StoreNumber: Array = [Int]()
    static var colors: [String] = ["#004797","#FFBE3D","#FF5456","#4AECFF","#3192FF","#1CC47B","#FFBE3D","#4AECFF"]
    static var labelVersion = 1
    static var monthsNumber = 0
    static var weekNumber = 0
    static var isMonthSelected = true


    
    
}
