//
//  APIUrl.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import Foundation

let BaseUrl = "http://10.45.10.10:3462"
let PublicUrl = "https://mrapp.carrefoursa.com"
let MemberUrl = "\(PublicUrl)/api/Account/Login"
let OtpUrl = "\(PublicUrl)/api/Account/OtpCheck"
let ResendCode = "\(PublicUrl)/api/Account/ResendCode"
let Confirm =  "\(PublicUrl)/api/Account/Confirmation"
let LogOut = "\(PublicUrl)/api/Account/Logout"
let Chart = "\(PublicUrl)/api/Dashboard/GetAllNumberOfStores"
let DashboardCard = "\(PublicUrl)/api/Dashboard/DashboardCards"
let NetSalesCards = "\(PublicUrl)/api/Dashboard/NetSalesTurnover"
let CustomerUrl = "\(PublicUrl)/api/Dashboard/Customer"
let ProductUrl = "\(PublicUrl)/api/Dashboard/Product"
let BasketUrl = "\(PublicUrl)/api/Dashboard/AverageBasket"
let PriceUrl = "\(PublicUrl)/api/Dashboard/AveragePrice"
let AuthenticaUrl = "\(PublicUrl)/api/Account/AuthenticateDevice"
let GetVersionUrl = "\(PublicUrl)/api/Account/GetVersion"
let UpdateVersionUrl = "\(PublicUrl)/api/Account/UpdateVersion"

