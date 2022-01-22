//
//  GetTableUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 01/11/21.
//

import Foundation

protocol GetTableUseCaseProtocol {
    typealias Failure = ((String) -> Void)?
    typealias Success = ((Table) -> Void)?
    
    func execute(id: String, failure: Failure, success: Success)
}

class GetTableUseCase: GetTableUseCaseProtocol {
    
    // MARK: - Private properties
    
    private var api: TableRoutesProtocol
    
    // MARK: - Init
    
    init(api: TableRoutesProtocol) {
        self.api = api
    }
    
    func execute(id: String, failure: Failure, success: Success) {
        api.tableData(id: id, failure: failure, success: { table in
            success?(table)
        })
    }
}
