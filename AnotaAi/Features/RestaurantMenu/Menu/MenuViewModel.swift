//
//  MenuViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

protocol MenuProtocol: MenuViewModelProtocol {
    func createTable()
}

class MenuViewModel {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private let createTableUseCase: CreateTableUseCaseProtocol?
    
    // MARK: - Init
    
    init(createTableUseCase: CreateTableUseCaseProtocol?) {
        self.createTableUseCase = createTableUseCase
    }
    
    func createTable() {
        
    }
}

extension MenuViewModel: MenuProtocol {}
