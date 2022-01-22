//
//  MenuRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

protocol MenuRoutesProtocol {
    func menuData<T: Codable>(ids: [String], failure: ((String) -> Void)?, success: (([T?]) -> Void)?)
}

class MenuRoutes {
    private let provider: ApiProtocol = Api()
}

extension MenuRoutes: MenuRoutesProtocol {
    func menuData<T: Codable>(ids: [String], failure: ((String) -> Void)?, success: (([T?]) -> Void)?) {
        
        provider.db.collection("menu")
            .document(ids[0]).collection(ids[1])
            .document(ids[2]).collection(ids[3]).addSnapshotListener { snapshot, error in
            guard let query = snapshot else {
                failure?(error?.localizedDescription ?? "")
                return
            }
            
            let models = query.documents.map { try? $0.data(as: T.self) }
            
            success?(models)
        }
        
    }
}
