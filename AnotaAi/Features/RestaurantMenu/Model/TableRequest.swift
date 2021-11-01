//
//  Table.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

struct Table: Encodable {
    var id: String = ""
    var persons: [PersonRequest] = []
    
    func toJSON() -> [String: Any] {
        let params: [String: Any] = ["id": id]
        return params
    }
}
