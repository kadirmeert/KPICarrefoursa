//
//  MainModel.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.10.2022.
//

import Foundation


struct DashboardCards: Decodable {
    
    var NetSales = [String]()
    var NetSalesvs2021 = [String]()
    var NetSalesvs2022B = [String]()
    var NetSalesvsButceLE = [String]()
    var Customer = [String]()
    var Customervs2021 = [String]()
    var Product = [String]()
    var Productvs2021 = [String]()
    var AverageBasket = [String]()
    var AverageBasketVs2021 = [String]()
    var AveragePrice = [String]()
    var AveragePriceVs2021 = [String]()
    var Area = [Int]()
    var StoreNumber = [Int]()
    var last_update = [String]()
    
    
}

