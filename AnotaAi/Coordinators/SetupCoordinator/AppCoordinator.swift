//
//  AppCoordinator.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 25/04/21.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private let session: AnotaAiSessionProtocol
    private(set) var childCoordinator: CoordinatorProtocol?
    
    init(window: UIWindow, session: AnotaAiSessionProtocol = AnotaAiSession.shared) {
        self.window = window
        self.session = session
        session.verifySession()
    }
    
    func start() {
        window.rootViewController = coordinatorBySession()
        window.makeKeyAndVisible()
    }
    
    // MARK: - Coordinator by session
    
    private func coordinatorBySession() -> UIViewController {
        if session.hasSession {
            let coordinator = HomeCoordinator()
            childCoordinator = coordinator
            return coordinator.containerViewController
        }
        
        let coordinator = WelcomeCoordinator()
        childCoordinator = coordinator
        return coordinator.start()
    }
    
    private func replaceRootViewController(_ viewController: UIViewController) {
        viewController.modalTransitionStyle = .crossDissolve
        UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = viewController
        })
    }
}
