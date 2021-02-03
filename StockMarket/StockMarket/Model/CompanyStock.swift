//
//  CompanyStock.swift
//  StockMarket
//
//  Created by Macbook Air on 20/01/2021.
//

import Foundation

public struct CompanyStock: Decodable  {
    
    let symbol: String
    let name: String
    let type: String
    let region: String
    let marketOpen: String
    let marketClose: String
    let timeZone: String
    let currency: String
    let matchScore: String

    public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CompanyStockDecodeKeys.self)
           symbol = try container.decode(String.self, forKey: .symbol)
           name = try container.decode(String.self, forKey: .name)
           type = try container.decode(String.self, forKey: .type)
           region = try container.decode(String.self, forKey: .region)
           marketOpen = try container.decode(String.self, forKey: .marketOpen)
           marketClose = try container.decode(String.self, forKey: .marketClose)
           timeZone = try container.decode(String.self, forKey: .timeZone)
           currency = try container.decode(String.self, forKey: .currency)
           matchScore = try container.decode(String.self, forKey: .matchScore)
       }
       
    enum CompanyStockDecodeKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timeZone = "7. timezone"
        case currency = "8. currency"
        case matchScore = "9. matchScore"
    }
    
}
