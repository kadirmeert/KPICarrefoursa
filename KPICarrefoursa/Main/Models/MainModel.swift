//
//  MainModel.swift
//  KPICarrefoursa
//
//  Created by Mert on 21.10.2022.
//

import Foundation


struct DashboardCards: Decodable {
    
    var NetSales = [Double]()
    var NetSalesvs2021 = [Double]()
    var NetSalesvs2022B = [Double]()
    var ButceLE = [Double]()
    var Customer = [Double]()
    var Customervs2021 = [Double]()
    var Product = [Double]()
    var Productvs2021 = [Double]()
    var AverageBasket = [Double]()
    var AverageBasketvs2021 = [Double]()
    var AveragePrice = [Double]()
    var AveragePricevs2021 = [Double]()
    var Area = [Int]()
    var StoreNumber = [Int]()
    var last_update = [String]()
    
    
}

