//
//  HomeCoordinator.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation
import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
    var childCoordinator: CoordinatorProtocol?
    weak var childDelegate: ChildCoordinatorDelegate?
    
    var containerViewController: UIViewController {
        return homeController
    }
    
    private lazy var homeController = HomeFactory.home(delegate: self)
    
    private lazy var menuCoordinator: MenuCoordinator = {
        let coordinator = MenuCoordinator()
        _ = coordinator.start()
        return coordinator
    }()
    
    private lazy var commandCoordinator: CommandCoordinator = {
        let coordinator = CommandCoordinator()
        _ = coordinator.start()
        return coordinator
    }()
}

extension HomeCoordinator: HomeControllerDelegate {
    
    func getViewControllerBy(tab: HomeTab) -> UIViewController {
        switch tab {
            case .menu:
                childCoordinator = menuCoordinator
                return menuCoordinator.containerViewController
            case .requests:
                childCoordinator = commandCoordinator
                return commandCoordinator.containerViewController
            case .profile:
                return UIViewController()
        }
    }
}
