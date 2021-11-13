//
//  CommandRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 11/11/21.
//

import FirebaseFirestore

protocol CommandRoutesProtocol {
    func addToCommand(item: Item, ids: [String], success: ((String) -> Void)?, failure: ((String) -> Void)?)
    func updatePersonCommand(ids: [String], success: (() -> Void)?, failure: ((String) -> Void)?)
}

class CommandRoutes {
    
    private let provider: ApiProtocol = Api()
}

extension CommandRoutes: CommandRoutesProtocol {
    
    func addToCommand(item: Item, ids: [String], success: ((String) -> Void)?, failure: ((String) -> Void)?) {
        var ref: DocumentReference?
        do {
            ref = try provider.db.collection("tables/\(ids[0])/commands").addDocument(from: item)
            success?(ref?.documentID ?? "")
        } catch let error {
            failure?(error.localizedDescription)
        }
    }
    
    func updatePersonCommand(ids: [String], success: (() -> Void)?, failure: ((String) -> Void)?) {
        provider.db.collection("tables/\(ids[0])/persons").document(ids[1]).updateData([
            "commands": FieldValue.arrayUnion([ids[2]])
        ])
        success?()
    }
}

