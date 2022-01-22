//
//  AddToCommandCoordinator.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

import UIKit

class AddToCommandCoordinator: CoordinatorProtocol {
    
    // MARK: - Public properties
    
    weak var childDelegate: ChildCoordinatorDelegate?
    var childCoordinator: CoordinatorProtocol?
    
    var containerViewController: UIViewController {
        navigationController
    }
    
    // MARK: - Private properties
    
    private var navigationController = UINavigationController()
    
    // MARK: - Start
    
    func start() -> UIViewController {
        let vc = MenuFactory.addToCommand(delegate: self)
        navigationController.modalPresentationStyle = .pageSheet
        navigationController.setViewControllers([vc], animated: true)
        return navigationController
    }
}

extension AddToCommandCoordinator: AddToCommandControllerDelegate {
    
}
