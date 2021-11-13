//
//  AddToCommandUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 11/11/21.
//

import Foundation

protocol AddToCommandUseCaseProtocol {
    typealias Success = (() -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(item: Item, ids: [String], success: Success?, failure: Failure?)
}

class AddToCommandUseCase: AddToCommandUseCaseProtocol {
    
    // MARK: - Private properties
    
    private let api: CommandRoutesProtocol
    
    // MARK: - Init
    
    init(api: CommandRoutesProtocol) {
        self.api = api
    }
    
    func execute(item: Item, ids: [String], success: Success? = nil, failure: Failure? = nil) {
        api.addToCommand(item: item, ids: ids, success: { [weak self] itemId in
            var idsWithItem = ids
            idsWithItem.append(itemId)
            self?.updatePersonCommand(
                ids: idsWithItem,
                success: success,
                failure: failure
            )
        }, failure: failure)
    }
    
    private func updatePersonCommand(ids: [String], success: Success?, failure: Failure?) {
        api.updatePersonCommand(
            ids: ids,
            success: success,
            failure: failure)
    }
}
