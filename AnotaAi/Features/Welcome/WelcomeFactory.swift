//
//  WelcomeFactory.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import Foundation
import UIKit

enum WelcomeFactory {
    
    static func welcome(delegate: WelcomeControllerDelegate?) -> UIViewController {
        let tableRoutes = TableRoutes()
        let createTablesUseCase = CreateTableUseCase(api: tableRoutes)
        let getTablesUseCase = GetTableUseCase(api: tableRoutes)
        let addPersonUseCase = AddPersonUseCase(api: tableRoutes)
        let createSessionUseCase = CreateSessionUseCase(session: AnotaAiSession.shared)
        
        let viewModel = WelcomeViewModel(
            getTablesUseCase: getTablesUseCase,
            createTablesUseCase: createTablesUseCase,
            addPersonUseCase: addPersonUseCase,
            createSessionUseCase: createSessionUseCase
        )
        return WelcomeController(viewModel: viewModel, delegate: delegate)
    }
}
