//
//  Table.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

struct Table: Codable {
    var id: String = ""
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case password
    }
}
