//
//  CommandViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation
import SwiftUI

protocol CommandProtocol: CommandViewModelProtocol {
    var onFailureGetCommands: ((String) -> Void)? { get set }
    var onSuccessGetCommands: (() -> Void)? { get set }
    func getCommands()
}

class CommandViewModel {
    
    // MARK: - Public properties
    
    var onChangeCommands: (([CommandCellViewModelProtocol]) -> Void)?
    var onFailureGetCommands: ((String) -> Void)?
    var onSuccessGetCommands: (() -> Void)?
    var onStartGetCommands: (() -> Void)?
    
    // MARK: - Private properties
    
    private var commandsUseCase: CommandUseCaseProtocol
    
    // MARK: - Init
    
    init(commandsUseCase: CommandUseCaseProtocol) {
        self.commandsUseCase = commandsUseCase
    }
    
    // MARK: - Sections
    
    private func generateSections(_ commands: [Item?]) {
        let viewModels = commands.map {
            CommandCellViewModel(
                title: $0?.name,
                subtitle: $0?.observation,
                status: $0?.status,
                value: $0?.value,
                size: $0?.size,
                clientName: $0?.clientName
            )
        }
        onChangeCommands?(viewModels)
    }
}

extension CommandViewModel: CommandProtocol {
    
    func getCommands() {
        guard let tableId = AnotaAiSession.shared.user?.tableId else {
            onFailureGetCommands?("Falha ao encontrar sua mesa")
            return
        }
        
        onStartGetCommands?()
        commandsUseCase.execute(
            tableId: tableId,
            success: { [weak self] commands in
                self?.onSuccessGetCommands?()
                self?.generateSections(commands)
            },
            failure: { [weak self] error in
                self?.onFailureGetCommands?(error.description)
            }
        )
    }
}
