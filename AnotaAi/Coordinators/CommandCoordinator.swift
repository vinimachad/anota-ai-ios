//
//  CommandCoordinator.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation

import UIKit

class CommandCoordinator: CoordinatorProtocol {
    
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
        let vc = CommandFactory.command(delegate: self)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setViewControllers([vc], animated: true)
        return navigationController
    }
}

extension CommandCoordinator: CommandControllerDelegate {
    
}
