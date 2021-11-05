//
//  HomeController.swift
//  Muvver
//
//  Created by mano on 09/07/20.
//  Copyright © 2020 Jera. All rights reserved.
//

import UIKit

protocol HomeControllerDelegate: AnyObject {
    func getViewControllerBy(tab: HomeTab) -> UIViewController
}

class HomeController<ViewModel: HomeProtocol>: UIViewController {
    
    private var viewModel: ViewModel
    private let contentView: HomeView
    private weak var delegate: HomeControllerDelegate?
    
    private(set) var childViewController: UIViewController? {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Init
    
    init(viewModel: ViewModel, delegate: HomeControllerDelegate?) {
        self.viewModel = viewModel
        self.contentView = HomeView.loadNib()
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller life cycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let childViewController = childViewController {
            return childViewController.preferredStatusBarStyle
        }
        
        return super.preferredStatusBarStyle
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension HomeController {
    
    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onSelectHomeTab = { [weak self] tab in
            if let viewController = self?.delegate?.getViewControllerBy(tab: tab) {
                self?.addViewController(viewController)
            }
        }
    }
    
    private func addViewController(_ viewController: UIViewController) {
        if let oldViewController = childViewController {
            oldViewController.remove()
        }
        
        addChild(viewController)
        contentView.addViewAboveTabBar(viewController.view)
        viewController.didMove(toParent: self)
        childViewController = viewController
    }
}
