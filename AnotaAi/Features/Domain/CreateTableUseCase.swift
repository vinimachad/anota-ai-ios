//
//  createTableUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import FirebaseFirestore

protocol CreateTableUseCaseProtocol {
    typealias Success = (() -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(_ path: String, request: Table, success: Success?, failure: Failure?)
}

class CreateTableUseCase: CreateTableUseCaseProtocol {
    
    // MARK: - Private properties
    
    var api: TableRoutesProtocol
    
    // MARK: - Init
    
    init(api: TableRoutesProtocol) {
        self.api = api
    }
    
    func execute(_ path: String, request: Table, success: Success? = nil, failure: Failure?) {
        api.createTable(path, request: request, failure: failure, success: success)
    }
}
