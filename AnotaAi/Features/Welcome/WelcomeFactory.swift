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
        let createPersonUseCaseProtocol = CreatePersonUseCase(api: PersonRoutes())
        let viewModel = WelcomeViewModel(createPersonUseCase: createPersonUseCaseProtocol)
        return WelcomeController(viewModel: viewModel, delegate: delegate)
    }
}
