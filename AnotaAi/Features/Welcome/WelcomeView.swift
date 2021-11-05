//
//  WelcomeView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import UIKit

protocol WelcomeViewModelProtocol {
    var scannerView: QRScannerView { get }
    func didChangeName(_ text: String?)
}
 
class WelcomeView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var titleView: TitleView!
    @IBOutlet private weak var nameTextField: TextField!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private(set) weak var scrollView: UIScrollView!
    private var scannerView: QRScannerView?
    
    // MARK: - Private properties
    
    private(set) var viewModel: WelcomeViewModelProtocol?
    
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: WelcomeViewModelProtocol) {
        self.viewModel = viewModel
        self.scannerView = viewModel.scannerView
        setupScanView()
    }
}

extension WelcomeView {
    
    // MARK: - Actions
    
    @objc private func didChangeName() {
        viewModel?.didChangeName(nameTextField.text)
    }
    
    // MARK: - View setup
    
    private func setup() {
        setupTitleView()
        setupTextField()
    }
    
    private func setupTitleView() {
        titleView.title = "screen_title".localize(.welcome)
        titleView.subtitle = "subtitle_label".localize(.welcome)
    }
    
    private func setupScanView() {
        addSubview(scannerView ?? UIView())
        scannerView?.backgroundColor = UIColor.black
        scannerView?.layer.cornerRadius = 8
        
        scannerView?.layout {
            $0.leading.equal(leadingAnchor, constant: 16)
            $0.trailing.equal(trailingAnchor, constant: -16)
            $0.top.equal(contentView.bottomAnchor, constant: 24)
            $0.height.equalTo(400)
        }
    }
    
    private func setupTextField() {
        nameTextField.addTarget(self, action: #selector(didChangeName), for: .editingChanged)
        nameTextField.placeholder = "your_name_input_hint".localize(.restaurantMenu)
    }
}
