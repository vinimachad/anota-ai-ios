//
//  Person.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 31/10/21.
//

import Foundation

struct Person: Codable {
    var name: String?
}

extension Person {
    func toJSON() -> [String: Any] {
        var params: [String: Any] = [:]
        
        if let name = name {
            params["name"] = name
        }
        
        return params
    }
}
