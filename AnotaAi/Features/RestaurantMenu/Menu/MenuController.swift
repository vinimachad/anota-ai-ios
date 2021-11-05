//
//  MenuController.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

import UIKit

protocol MenuControllerDelegate: AnyObject {}

class MenuController<ViewModel: MenuProtocol>: UIViewController {
    
    // MARK: - Private properties
    
    private(set) var viewModel: ViewModel
    private(set) var contentView: MenuView
    private weak var delegate: MenuControllerDelegate?
    
    // MARK: - Init
    
    init(viewModel: ViewModel, delegate: MenuControllerDelegate?) {
        self.viewModel = viewModel
        self.contentView = MenuView.loadNib()
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.createTable()
    }
    
    // MARK: - Bind
    
    private func bind() {
        contentView.bindIn(viewModel: viewModel)
    }
}

