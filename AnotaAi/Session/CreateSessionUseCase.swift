//
//  CreateSessionUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 4/1/21.
//

import Foundation

protocol CreateSessionUseCaseProtocol {
    typealias Success = (() -> Void)
    typealias Failure = ((Error) -> Void)

    func execute(userSession: Person, success: Success?, failure: Failure?)
}

class CreateSessionUseCase: CreateSessionUseCaseProtocol {

    // MARK: - Private properties
    
    private let session: AnotaAiSessionProtocol
    
    // MARK: - Init

    init(session: AnotaAiSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Execute
    
    func execute(userSession: Person, success: Success? = nil, failure: Failure? = nil) {
        let personSession = PersonSession(name: userSession.name, tableId: userSession.tableId, token: userSession.token)
        do {
            try session.createSession(user: personSession)
            success?()
        } catch let error {
            failure?(error)
        }
    }
}
