//
//  AnotaAiSession.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado 4/11/2021.
//

import MSession

protocol AnotaAiSessionProtocol {
    var hasSession: Bool { get }
    var secretKey: String? { get }
    var user: PersonSession? { get }
    
    func createSession(user: PersonSession) throws
    func updateSession(user: PersonSession) throws
    func removeSession()
    func verifySession()
}

class AnotaAiSession: SessionManager<PersonSession> {
    
    static let shared: AnotaAiSessionProtocol = AnotaAiSession()
    
    // MARK: - Init
    
    private init() {
        super.init(service: "AnotaAiSessionKey")
    }
    
    // MARK: - Utils
    
    private var isFirstRun: Bool {
        UserDefaults.standard.object(forKey: "already_entered") == nil
    }
        
    private func setFirstRun() {
        UserDefaults.standard.set("is_first_run", forKey: "already_entered")
    }
}

extension AnotaAiSession: AnotaAiSessionProtocol {
    
    var hasSession: Bool {
        return session != nil
    }
    
    func createSession(user: PersonSession) throws {
        try self.createSession(secretKey: user.token, user: user)
    }
    
    func updateSession(user: PersonSession) throws {
        try self.updateSession(secretKey: user.token, user: user)
    }
    
    func removeSession() {
        self.logout()
    }
    
    func verifySession() {
        guard isFirstRun else {
            return
        }
        
        removeSession()
        setFirstRun()
    }
}
