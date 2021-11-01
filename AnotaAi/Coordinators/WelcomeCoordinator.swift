//
//  WelcomeCoordinator.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import Foundation

import UIKit

class WelcomeCoordinator: CoordinatorProtocol {
    
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
        let vc = WelcomeFactory.welcome(delegate: self)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setViewControllers([vc], animated: true)
        return navigationController
    }
}

extension WelcomeCoordinator: WelcomeControllerDelegate {
    func openTable(tableRequest: Table) {
        let coordinator = MenuCoordinator()
        childDelegate = coordinator.childDelegate
        navigationController.present(coordinator.start(tableRequest: tableRequest), animated: true)
        childCoordinator = coordinator
    }
}
