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
        let createTableUseCase = CreateTableUseCase(api: TableRoutes())
        let viewModel = MenuViewModel(createTableUseCase: createTableUseCase)
        return MenuController(viewModel: viewModel, delegate: delegate)
    }
}
