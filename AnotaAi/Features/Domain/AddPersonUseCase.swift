//
//  AddPersonUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 03/11/21.
//

import Foundation

protocol AddPersonUseCaseProtocol {
    typealias Success = ((String) -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(request: Person, success: Success?, failure: Failure?)
}

class AddPersonUseCase: AddPersonUseCaseProtocol {
    
    // MARK: - Private properties
    
    var api: TableRoutesProtocol
    
    // MARK: - Init
    
    init(api: TableRoutesProtocol) {
        self.api = api
    }
    
    func execute(request: Person, success: Success? = nil, failure: Failure?) {
        api.addPersonsInTable(
            request: request,
            tableId: request.tableId ?? "",
            failure: failure,
            success: success
        )
    }
}
