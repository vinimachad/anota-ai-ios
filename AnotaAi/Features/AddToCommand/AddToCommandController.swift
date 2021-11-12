//
//  AddToCommandController.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

import UIKit

protocol AddToCommandControllerDelegate: AnyObject {}

class AddToCommandController<ViewModel: AddToCommandProtocol>: UIViewController, KeyboardHandler {

    var scrollView: UIScrollView? {
        contentView.scrollView
    }
    
    // MARK: - Private properties
    
    private(set) var viewModel: ViewModel
    private(set) var contentView: AddToCommandView
    private weak var delegate: AddToCommandControllerDelegate?
    
    // MARK: - Init
    
    init(viewModel: ViewModel, delegate: AddToCommandControllerDelegate?) {
        self.viewModel = viewModel
        self.contentView = AddToCommandView.loadNib()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startObserveKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopObserveKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setTransparentNavigation()
    }
    
    // MARK: - Bind
    
    private func bind() {
        contentView.bindIn(viewModel: viewModel)
    }
}

