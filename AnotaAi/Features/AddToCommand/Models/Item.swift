//
//  Item.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 10/11/21.
//

import Foundation

class Item: Codable {
    
    var name: String = ""
    var isHalf: Bool = false
    var size: String = "M"
    var foodIds: [String] = []
    var observation: String = ""
    var howMany: Int = 1
    var value: Double = 0.0
    var status: String = "aguardando"
    var clientName: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case isHalf
        case size
        case observation
        case howMany
        case value
        case status
        case foodIds
        case clientName
    }
}
