//
//  TableRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import FirebaseFirestore

protocol TableRoutesProtocol {
    typealias Failure = ((String) -> Void)?
    typealias Success = (() -> Void)?
    
    func createTable(_ path: String, id: String, request: Table, failure: Failure, success: Success)
    func tableData<T: Codable>(_ path: String, id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?)
    func addPersonsInTable<T: Codable>(_ path: String, request: T, failure: ((String) -> Void)?, success: ((String) -> Void)?)
}

class TableRoutes {
    
    private let provider: ApiProtocol = Api()
}

extension TableRoutes: TableRoutesProtocol {
    
    func createTable(_ path: String, id: String, request: Table, failure: Failure, success: Success) {
        provider.insertData(path, id: id, data: request, failure: failure, success: { _ in
            success?()
        })
    }
    
    func addPersonsInTable<T: Codable>(_ path: String, request: T, failure: ((String) -> Void)?, success: ((String) -> Void)?) {
        provider.insertData(path, id: nil, data: request, failure: failure, success: success)
    }
    
    func tableData<T: Codable>(_ path: String, id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?) {
        provider.getData(path, id: id, failure: failure, success: success)
    }
}
