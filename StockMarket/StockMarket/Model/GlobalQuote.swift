//
//  GlobalQuote.swift
//  StockMarket
//
//  Created by Macbook Air on 25/01/2021.
//
import Foundation

public struct GlobalQuote : Decodable {
    
    let symbol: String
    let open: String
    let high: String
    let low: String
    let price: String
    let volume: String
    let latestTradingDay: String
    let previuousClose: String
    let change: String
    var changePercent: String
    
 public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CompanyStockDecodeKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        high = try container.decode(String.self, forKey: .high)
        low = try container.decode(String.self, forKey: .low)
        open = try container.decode(String.self, forKey: .open)
        volume = try container.decode(String.self, forKey: .volume)
        price = try container.decode(String.self, forKey: .price)
        latestTradingDay = try container.decode(String.self, forKey: .latestTradingDay)
        previuousClose = try container.decode(String.self, forKey: .previuousClose)
        change = try container.decode(String.self, forKey: .change)
        changePercent = try container.decode(String.self, forKey: .changePercent)
    }
    
    enum CompanyStockDecodeKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case latestTradingDay = "07. latest trading day"
        case previuousClose = "08. previous close"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
}
