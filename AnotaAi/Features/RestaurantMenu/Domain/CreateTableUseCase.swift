//
//  createTableUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import FirebaseFirestore

protocol CreateTableUseCaseProtocol {
    typealias Success = ((Table) -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(request: Table, success: Success?, failure: Failure?)
}

class CreateTableUseCase: CreateTableUseCaseProtocol {
    
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
            success: { [weak self] in
                self?.getTableDatas(id: request.id, success: success, failure: failure)
            }
        )
    }
    
    private func getTableDatas(id: String, success: ((Table) -> Void)?, failure: ((String) -> Void)?) {
        api.tableData(id: id, failure: failure, success: { table in
            success?(table)
        })
    }
    
}
