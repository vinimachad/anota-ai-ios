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
    
    func execute(request: Table, success: Success?, failure: Failure?)
}

class UpdateTableUseCase: CreateTableUseCaseProtocol {
    
    // MARK: - Private properties
    
    var api: TableRoutesProtocol
    
    // MARK: - Init
    
    init(api: TableRoutesProtocol) {
        self.api = api
    }
    
    func execute(request: Table, success: Success? = nil, failure: Failure?) {
        api.createTable(
            request: request,
            failure: failure,
            success: success
        )
    }
}
