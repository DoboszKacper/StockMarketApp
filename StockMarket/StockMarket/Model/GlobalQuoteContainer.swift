//
//  GlobalQuoteContainer.swift
//  StockMarket
//
//  Created by Macbook Air on 25/01/2021.
//

import Foundation

struct GlobalQuoteContainer: Decodable {
    
    var globalQuote: GlobalQuote
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        globalQuote = try container.decode(GlobalQuote.self, forKey: .globalQuoteJson)
    }
    
    enum DecodingKeys: String, CodingKey {
        case globalQuoteJson = "Global Quote"
    }
}
