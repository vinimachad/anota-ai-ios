//
//  CommandUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation

protocol CommandUseCaseProtocol {
    typealias Success = (([Item?]) -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(tableId: String, success: Success?, failure: Failure?)
}

class CommandUseCase: CommandUseCaseProtocol {
    
    // MARK: - Private properties
    
    private let api: CommandRoutesProtocol
    
    // MARK: - Init
    
    init(api: CommandRoutesProtocol) {
        self.api = api
    }
    
    func execute(tableId: String, success: Success? = nil, failure: Failure? = nil) {
        api.commands(tableId, success: success, failure: failure)
    }
}
