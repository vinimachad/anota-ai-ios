//
//  MenuRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

protocol MenuRoutesProtocol {
    func menuData<T: Codable>(_ path: String, failure: ((String) -> Void)?, success: (([T?]) -> Void)?)
}

class MenuRoutes {
    private let provider: ApiProtocol = Api()
}

extension MenuRoutes: MenuRoutesProtocol {
    func menuData<T: Codable>(_ path: String, failure: ((String) -> Void)?, success: (([T?]) -> Void)?) {
        provider.getDatas(path, failure: failure, success: success)
    }
}
