//
//  PersonSession.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 31/10/21.
//

import Foundation

final class PersonSession: NSObject, NSCoding {
    
    // MARK: - Public properties
    
    var token: String?
    var name: String?
    var tableId: String?
    
    // MARK: - Init
    
    init(name: String? = nil, tableId: String? = nil, token: String? = nil) {
        self.name = name
        self.tableId = tableId
        self.token = token
    }
    
    convenience required init?(coder: NSCoder) {
        guard let token = coder.decodeObject(forKey: CodingKeys.token.rawValue) as? String,
              let name = coder.decodeObject(forKey: CodingKeys.name.rawValue) as? String,
              let tableId = coder.decodeObject(forKey: CodingKeys.tableId.rawValue) as? String
        else { return nil }
        
        self.init(name: name, tableId: tableId, token: token)
    }
    
    // MARK: - Encode
    
    func encode(with coder: NSCoder) {
        coder.encode(token, forKey: CodingKeys.token.rawValue)
        coder.encode(name, forKey: CodingKeys.name.rawValue)
        coder.encode(tableId, forKey: CodingKeys.tableId.rawValue)
    }
}

extension PersonSession {
    
    enum CodingKeys: String, CodingKey {
        case token
        case name
        case tableId
    }
}
