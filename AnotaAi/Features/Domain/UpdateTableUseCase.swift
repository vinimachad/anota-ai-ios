//
//  UpdateTableUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 03/11/21.
//

import Foundation

protocol UpdateTableUseCaseProtocol {
    typealias Success = (() -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(_ path: String, request: Table, success: Success?, failure: Failure?)
}

class UpdateTableUseCase: UpdateTableUseCaseProtocol {
    
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
