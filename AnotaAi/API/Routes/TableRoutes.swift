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
    
    func createTable(request: Table, failure: Failure, success: Success)
    func tableData<T: Codable>(id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?)
}

class TableRoutes {
    
    private let provider: ApiProtocol = Api()
}

extension TableRoutes: TableRoutesProtocol {
    
    func createTable(request: Table, failure: Failure, success: Success) {
        provider.insertData("tables", id: request.id, data: request, failure: failure, success: success)
    }
    
    func tableData<T: Codable>(id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?) {
        provider.getData("tables", id: id, failure: failure, success: success)
    }
}
