//
//  APIUrl.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import Foundation

let BaseUrl = "http://10.45.10.10:3462"
let TestUrl = "http://10.45.10.90:7260"
let MemberUrl = "\(TestUrl)/api/Account/Login"
let OtpUrl = "\(TestUrl)/api/Account/OtpCheck"
let ResendCode = "\(TestUrl)/api/Account/ResendCode"
let Confirm =  "\(TestUrl)/api/Account/Confirmation"
let LogOut = "\(TestUrl)/api/Account/Logout"
let Chart = "\(TestUrl)/api/Dashboard/GetAllNumberOfStores"
let DashboardCard = "\(TestUrl)/api/Dashboard/DashboardCards"
let NetSalesCards = "\(TestUrl)/api/Dashboard/NetSalesTurnover"
let CustomerUrl = "\(TestUrl)/api/Dashboard/Customer"
let ProductUrl = "\(TestUrl)/api/Dashboard/Product"
let BasketUrl = "\(TestUrl)/api/Dashboard/AverageBasket"
let PriceUrl = "\(TestUrl)/api/Dashboard/AveragePrice"
let AuthenticaUrl = "\(TestUrl)/api/Account/AuthenticateDevice"



