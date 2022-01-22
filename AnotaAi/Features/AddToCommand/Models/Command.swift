//
//  Command.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 11/11/21.
//

import Foundation

struct Command: Codable {
    var items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
