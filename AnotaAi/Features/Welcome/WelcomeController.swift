//
//  WelcomeController.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import UIKit

protocol WelcomeControllerDelegate: AnyObject {
    func openTable()
}

class WelcomeController<ViewModel: WelcomeProtocol>: UIViewController, KeyboardHandler {
    
    var scrollView: UIScrollView? {
        contentView.scrollView
    }
    
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
}

extension WelcomeController {
    
    // MARK: - Bind
    
    private func bind() {
        contentView.bindIn(viewModel: viewModel)
        
        viewModel.onSuccessGetQRCodeValue = { [weak self] request in
            self?.delegate?.openTable()
        }
        
        viewModel.onFailureGetQRCodeValue = { [weak self] error in
            self?.showAlert(title: "alert_error_title".localize(.error), message: error)
            self?.viewModel.startScan()
        }
        
        viewModel.onPutPassword = { [weak self]  in
            self?.showTextFieldAlert(
                title: "table_password_alert_title".localize(.welcome),
                message: "which_password_alert_message".localize(.welcome),
                completion: { [weak self] password in
                    self?.viewModel.passwordValidation(password)
                }
            )
        }
        
        viewModel.onCreateTable = { [weak self] in
            self?.showTextFieldAlert(
                title: "passowrd_alert_title".localize(.welcome),
                message: "add_password_alert_message".localize(.welcome),
                completion: { [weak self] password in
                    self?.viewModel.didCreateTable(password)
                }
            )
        }
    }
}
