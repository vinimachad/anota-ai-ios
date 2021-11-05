//
//  WelcomeView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/10/21.
//

import UIKit

protocol WelcomeViewModelProtocol {
    var scannerView: QRScannerView { get }
}
 
class WelcomeView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var titleView: TitleView!
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

// MARK: - View setup

extension WelcomeView {
    private func setup() {
        setupTitleView()
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
            $0.height.equalTo(400)
            $0.centerY.equal(centerYAnchor)
        }
    }
}
