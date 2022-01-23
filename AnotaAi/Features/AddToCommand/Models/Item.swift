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
    var otherFood: Food?
    var observation: String = ""
    var howMany: Int = 1
    var value: Double = 0.0
    var status: String = "aguardando"
    
    enum CodingKeys: String, CodingKey {
        case name
        case isHalf
        case size
        case otherFood
        case observation
        case howMany
        case value
        case status
    }
}
