//
//  MenuFactory.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import UIKit
import MSession

enum MenuFactory {
    static func table(delegate: MenuControllerDelegate?) -> UIViewController {
        let menuUseCase = MenuUseCase(api: MenuRoutes())
        let viewModel = MenuViewModel(menuUseCase: menuUseCase)
        return MenuController(viewModel: viewModel, delegate: delegate)
    }
    
    static func addToCommand(delegate: AddToCommandControllerDelegate?, food: Food?, foods: [Food?]) -> UIViewController {
        let addToCommandUseCase = AddToCommandUseCase(api: CommandRoutes())
        let viewModel = AddToCommandViewModel(
            food: food,
            foods: foods,
            addToCommandUseCase: addToCommandUseCase,
            session: AnotaAiSession.shared.user
        )
        return AddToCommandController(viewModel: viewModel, delegate: delegate)
    }
}
