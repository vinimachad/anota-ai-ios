//
//  AddToCommandUseCase.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 11/11/21.
//

import Foundation
import FirebaseFirestore

protocol AddToCommandUseCaseProtocol {
    typealias Success = (() -> Void)
    typealias Failure = ((String) -> Void)
    
    func execute(_ paths: [String], item: Item, success: Success?, failure: Failure?)
}

class AddToCommandUseCase: AddToCommandUseCaseProtocol {
    
    // MARK: - Private properties
    
    private let api: CommandRoutesProtocol
    
    // MARK: - Init
    
    init(api: CommandRoutesProtocol) {
        self.api = api
    }
    
    func execute(_ paths: [String], item: Item, success: Success? = nil, failure: Failure? = nil) {
        api.addToCommand(
            paths[0],
            item: item,
            success: { [weak self] id in
                let data = ["command": FieldValue.arrayUnion([id])]
                self?.updatePersonCommand(paths[1], id: paths[2], data: data, success: success, failure: failure)
            },
            failure: failure)
    }
    
    private func updatePersonCommand(_ path: String, id: String, data: [String: Any], success: Success?, failure: Failure?) {
        api.updatePersonCommand(path, docId: id, data: data, success: success)
    }
}
