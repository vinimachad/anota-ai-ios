//
//  Table.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

struct Table: Codable {
    var id: String = ""
    var persons: [Person] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case persons
    }
    
    func toJSON() -> [String: Any] {
        let params: [String: Any] = [
            "id": id,
            "persons": persons
        ]
        
        return params
    }
}
