//
//  CompanyStockContainer.swift
//  StockMarket
//
//  Created by Macbook Air on 24/01/2021.
//

import Foundation

struct CompanyStockContainer: Decodable {
    
    var companys: [CompanyStock]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        companys = try container.decode([CompanyStock].self, forKey: .bestMatches)
    }
    
    enum DecodingKeys: String, CodingKey {
        case bestMatches = "bestMatches"
    }
}
