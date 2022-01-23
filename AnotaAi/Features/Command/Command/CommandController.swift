//
//  CommandController.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation

import UIKit

protocol CommandControllerDelegate: AnyObject {}

class CommandController<ViewModel: CommandProtocol>: UIViewController {
    
    // MARK: - Private properties
    
    private(set) var viewModel: ViewModel
    private(set) var contentView: CommandView
    private weak var delegate: CommandControllerDelegate?
    
    // MARK: - Init
    
    init(viewModel: ViewModel, delegate: CommandControllerDelegate?) {
        self.viewModel = viewModel
        self.contentView = CommandView.loadNib()
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
        viewModel.getCommands()
    }
    
    // MARK: - Bind
    
    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onFailureGetCommands = { error in
            print(error)
        }
    }
}

