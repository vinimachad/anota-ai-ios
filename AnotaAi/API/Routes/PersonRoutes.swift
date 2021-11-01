//
//  PersonRoutes.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 31/10/21.
//

import Foundation

import FirebaseFirestore

protocol PersonRoutesProtocol {
    func createPerson(request: Person, failure: ((String) -> Void)?, success: ((String) -> Void)?)
    func personData<T: Codable>(id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?)
}

class PersonRoutes {
    
    private let provider: ApiProtocol = Api()
}

extension PersonRoutes: PersonRoutesProtocol {
    
    func createPerson(request: Person, failure: ((String) -> Void)?, success: ((String) -> Void)?) {
        provider.insertDataWithoutId("persons", data: request, failure: failure, success: success)
    }
    
    func personData<T: Codable>(id: String, failure: ((String) -> Void)?, success: ((T) -> Void)?) {
        provider.getData("persons", id: id, failure: failure, success: success)
    }
}
