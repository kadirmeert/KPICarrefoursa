//
//  NumberOfStoresModel.swift
//  KPICarrefoursa
//
//  Created by Mert on 18.10.2022.
//
import Foundation

struct NumberOfStores: Decodable {
    
    var Area = [Int]()
    var City = [Int]()
    var Color = [String]()
    var FilterType = [String]()
    var Format = [String]()
    var LastUpdate = [String]()
    var StoreNumber = [Int]()
}
