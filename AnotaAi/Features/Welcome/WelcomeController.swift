//
//  WelcomeController.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import UIKit

protocol WelcomeControllerDelegate: AnyObject {
    func openTable(code: String)
}

class WelcomeController<ViewModel: WelcomeProtocol>: UIViewController {
    
    // MARK: - Private properties
    
    private var viewModel: ViewModel
    private var contentView: WelcomeView
    private weak var delegate: WelcomeControllerDelegate?
    
    // MARK: - Init
    
    init(viewModel: ViewModel, delegate: WelcomeControllerDelegate?) {
        self.viewModel = viewModel
        self.contentView = WelcomeView.loadNib()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startScan()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopScan()
    }
    
    // MARK: - Bind
    
    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onSuccessGetQRCodeValue = { [weak self] value in
            self?.delegate?.openTable(code: value)
        }
    }
}
