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

    func start() -> UIViewController {
        let vc = MenuFactory.table(delegate: self)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setViewControllers([vc], animated: true)
        return navigationController
    }
}

extension MenuCoordinator: MenuControllerDelegate {
    
    func openAddToCommand(_ food: Food?, foods: [Food?]) {
        let coordinator = AddToCommandCoordinator()
        childDelegate = coordinator.childDelegate
        navigationController.present(coordinator.start(food: food, foods: foods), animated: true)
        childCoordinator = coordinator
    }
}

extension MenuCoordinator: AddToCommandControllerDelegate { }
