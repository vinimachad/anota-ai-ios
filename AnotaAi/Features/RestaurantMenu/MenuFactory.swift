//
//  MenuFactory.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation
import UIKit

enum MenuFactory {
    static func table(delegate: MenuControllerDelegate?) -> UIViewController {
        let menuUseCase = MenuUseCase(api: MenuRoutes())
        let viewModel = MenuViewModel(menuUseCase: menuUseCase)
        return MenuController(viewModel: viewModel, delegate: delegate)
    }
    
    static func addToCommand(delegate: AddToCommandControllerDelegate?) -> UIViewController {
        let viewModel = AddToCommandViewModel()
        return AddToCommandController(viewModel: viewModel, delegate: delegate)
    }
}
