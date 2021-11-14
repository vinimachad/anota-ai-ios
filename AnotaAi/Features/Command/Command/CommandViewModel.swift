//
//  CommandViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation

protocol CommandProtocol: CommandViewModelProtocol {
    
}

class CommandViewModel {
    
    // MARK: - Public properties
    
    var onChangeSections: (([TableSectionProtocol]) -> Void)?
    
    // MARK: - Private properties
    
    // MARK: - Init
    
}

extension CommandViewModel: CommandProtocol {}
