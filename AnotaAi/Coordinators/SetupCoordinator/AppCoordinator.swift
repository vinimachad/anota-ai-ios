//
//  AppCoordinator.swift
//  app-template
//
//  Created by Vinicius Galhardo Machado on 25/04/21.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private(set) var childCoordinator: CoordinatorProtocol?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = coordinatorDefault()
        window.makeKeyAndVisible()
    }
    
    func coordinatorDefault() -> UIViewController {
        let homeCoordinator = HomeCoordinator()
        childCoordinator = homeCoordinator
        return homeCoordinator.start()
    }
}
