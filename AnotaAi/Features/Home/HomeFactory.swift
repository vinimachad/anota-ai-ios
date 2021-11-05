//
//  HomeFactory.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation
import UIKit

class HomeFactory {
    
    static func home(delegate: HomeControllerDelegate?) -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeController(viewModel: viewModel, delegate: delegate)
    }
}
