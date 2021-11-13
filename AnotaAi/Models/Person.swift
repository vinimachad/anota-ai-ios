//
//  Person.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 04/11/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Person: Codable {
    @DocumentID var token: String? = UUID().uuidString
    var name: String?
    var tableId: String?
    var command: Command?
    
    enum CodingKeys: String, CodingKey  {
        case token
        case name
        case tableId
        case command
    }
}
