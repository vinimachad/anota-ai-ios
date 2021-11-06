//
//  TextFieldView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 03/11/21.
//

import Foundation

import UIKit

protocol TextFieldViewModelProtocol {
    func didChange(_ text: String?)
}

class TextFieldView: UIView, NibLoadable {
    
    // MARK: - Public properties
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    // MARK: - UI Components
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: TextField!
    
    // MARK: - Private properties
    
    private(set) var viewModel: TextFieldViewModelProtocol?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func commonInit() {
        injectInterfaceFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: TextFieldViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - View setup

extension TextFieldView {
    private func setup() {
        setupTitleLabel()
        setupTextField()
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .blackColor
        titleLabel.font = .default(type: .semiBold, ofSize: 16)
    }
    
    private func setupTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Actions
    
    @objc private func textFieldDidChange() {
        viewModel?.didChange(textField.text)
    }
}
