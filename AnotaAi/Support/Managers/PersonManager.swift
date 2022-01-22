//
//  PersonManager.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 11/11/21.
//

import Foundation

protocol PersonManagerProtocol {
    var person: Person? { get }
    func createPerson(person: Person?)
}

class PersonManager: PersonManagerProtocol {
    
    // MARK: - Public properties
    
    static var shared: PersonManagerProtocol = PersonManager()
    var person: Person?
    
    // MARK: - Methods
    
    func createPerson(person: Person?) {
        guard let person = person else { return }
        self.person = person
    }
}
