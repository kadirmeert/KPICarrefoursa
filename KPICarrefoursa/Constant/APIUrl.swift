//
//  APIUrl.swift
//  KPICarrefoursa
//
//  Created by Mert on 3.10.2022.
//

import Foundation

let BaseUrl = "http://10.45.10.10:3462"
let TestUrl = "http://10.45.10.90:7260"
let MemberUrl = "\(BaseUrl)/api/Account/Login"
let OtpUrl = "\(BaseUrl)/api/Account/OtpCheck"
let ResendCode = "\(BaseUrl)/api/Account/ResendCode"
let Confirm =  "\(BaseUrl)/api/Account/Confirmation"
let LogOut = "\(BaseUrl)/api/Account/Logout"
let Chart = "\(BaseUrl)/api/Dashboard/GetAllNumberOfStores"
let DashboardCard = "\(BaseUrl)/api/Dashboard/DashboardCards"
let NetSalesCards = "\(BaseUrl)/api/Dashboard/NetSalesTurnover"
let CustomerUrl = "\(BaseUrl)/api/Dashboard/Customer"
let ProductUrl = "\(BaseUrl)/api/Dashboard/Product"
let BasketUrl = "\(BaseUrl)/api/Dashboard/AverageBasket"
let PriceUrl = "\(BaseUrl)/api/Dashboard/AveragePrice"
let AuthenticaUrl = "\(BaseUrl)/api/Account/AuthenticateDevice"



