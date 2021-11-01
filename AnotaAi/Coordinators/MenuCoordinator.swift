//
//  MenuCoordinator.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

import UIKit

class MenuCoordinator: CoordinatorProtocol {
    
    // MARK: - Public properties
    
    weak var childDelegate: ChildCoordinatorDelegate?
    var childCoordinator: CoordinatorProtocol?
    
    var containerViewController: UIViewController {
        navigationController
    }
    
    // MARK: - Private properties
    
    private var navigationController = UINavigationController()
    
    // MARK: - Start
    
    func start(tableRequest: Table) -> UIViewController {
        let vc = MenuFactory.table(delegate: self, tableRequest: tableRequest)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setViewControllers([vc], animated: true)
        return navigationController
    }
}

extension MenuCoordinator: MenuControllerDelegate {
    
}
