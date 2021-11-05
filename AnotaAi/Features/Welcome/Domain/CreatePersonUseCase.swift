//
//  CreatePersonUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 31/10/21.
//

import Foundation

protocol CreatePersonUseCaseProtocol {
    typealias Success = ((Person) -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(request: Person, success: Success?, failure: Failure?)
}

class CreatePersonUseCase: CreatePersonUseCaseProtocol {
    
    // MARK: - Private properties
    
    var api: PersonRoutesProtocol
    
    // MARK: - Init
    
    init(api: PersonRoutesProtocol) {
        self.api = api
    }
    
    func execute(request: Person, success: Success?, failure: Failure?) {
        api.createPerson(request: request, failure: failure, success: { [weak self] id in
            self?.getPerson(id, success: success, failure: failure)
        })
    }
    
    private func getPerson(_ id: String, success: ((Person) -> Void)?, failure: ((String) -> Void)?) {
        api.personData(id: id, failure: failure, success: { person in
            success?(person)
        })
    }
}
