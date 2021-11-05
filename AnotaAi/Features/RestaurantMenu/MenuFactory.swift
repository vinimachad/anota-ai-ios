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
        let viewModel = MenuViewModel()
        return MenuController(viewModel: viewModel, delegate: delegate)
    }
}
