//
//  CommandFactory.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation
import UIKit

enum CommandFactory {
    
    static func command(delegate: CommandControllerDelegate?) -> UIViewController {
        let commandsUseCase = CommandUseCase(api: CommandRoutes())
        let viewModel = CommandViewModel(commandsUseCase: commandsUseCase)
        return CommandController(viewModel: viewModel, delegate: delegate)
    }
}
