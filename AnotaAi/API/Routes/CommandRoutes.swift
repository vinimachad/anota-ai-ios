//
//  CommandRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 11/11/21.
//

import FirebaseFirestore

protocol CommandRoutesProtocol {
    func commands(_ tableId: String, success: (([Item?]) -> Void)?, failure: ((String) -> Void)?)
    func addToCommand(_ path: String, item: Item, success: ((String) -> Void)?, failure: ((String) -> Void)?)
    func updatePersonCommand(_ path: String, docId: String, data: [String: Any],  success: (() -> Void)?)
}

class CommandRoutes {
    
    enum Targets {
        case commands(String)
        
        var path: String {
            switch self {
            case let .commands(id): return "/tables/\(id)/commands/"
            }
        }
    }
    
    private let provider: ApiProtocol = Api()
}

extension CommandRoutes: CommandRoutesProtocol {
    
    func addToCommand(_ path: String, item: Item, success: ((String) -> Void)?, failure: ((String) -> Void)?) {
        provider.insertData(path, id: nil, data: item, failure: failure, success: success)
    }
    
    func updatePersonCommand(_ path: String, docId: String, data: [String: Any],  success: (() -> Void)?) {
        provider.updateData(path, docId: docId, data: data, success: success)
    }
    
    func commands(_ tableId: String, success: (([Item?]) -> Void)?, failure: ((String) -> Void)?) {
        provider.getDatas(Targets.commands(tableId).path, failure: failure, success: success)
    }
}

