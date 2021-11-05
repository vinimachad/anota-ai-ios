//
//  MenuUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

protocol MenuUseCaseProtocol {
    typealias Success = (([Food?]) -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(ids: [String], success: Success?, failure: Failure?)
}

class MenuUseCase: MenuUseCaseProtocol {
    
    // MARK: - Private properties
    
    private var api: MenuRoutesProtocol
    
    // MARK: - Init

    init(api: MenuRoutesProtocol) {
        self.api = api
    }
    
    func execute(ids: [String], success: Success?, failure: Failure?) {
        api.menuData(ids: ids, failure: failure, success: success)
    }
}
