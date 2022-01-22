//
//  Food.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Food: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var description: String
    var name: String
    var preview: String
    var price: Double
    var serves: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case name
        case preview
        case price
        case serves
    }
}
