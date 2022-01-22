//
//  TextFieldSideBySideView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

import UIKit
import SwiftUI

protocol TextFieldSideBySideViewModelProtocol {
    func textDidChange(text: String?, whichField: TextFieldSideBySideViewModelViewModel.WhichField)
}

class TextFieldSideBySideView: UIView, NibLoadable {
    
    // MARK: - Public properties
    
    var first: String? {
        get { firstLabel.text }
        set { firstLabel.text = newValue }
    }
    
    var second: String? {
        get { secondLabel.text }
        set { secondLabel.text = newValue }
    }
    
    var firstOptions: [String]? {
        get { firstPickerDataSource.options }
        set {
            firstTextField.text = newValue?[0]
            firstPickerDataSource.options = newValue ?? []
            firstTextField.createPicker(dataSource: firstPickerDataSource)
        }
    }
    var secondOptions: [String]? {
        get { secondPickerDataSource.options }
        set {
            secondTextField.text = newValue?[0]
            secondPickerDataSource.options = newValue ?? []
            secondTextField.createPicker(dataSource: secondPickerDataSource)
        }
    }
    
    // MARK: - UI Components
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet private weak var firstLabel: UILabel!
    @IBOutlet private weak var secondLabel: UILabel!
    @IBOutlet private weak var firstTextField: TextField!
    @IBOutlet private weak var secondTextField: TextField!
    
    // MARK: - Private properties
    
    private(set) var viewModel: TextFieldSideBySideViewModelProtocol?
    private(set) lazy var firstPickerDataSource = PickerDataSource()
    private(set) lazy var secondPickerDataSource = PickerDataSource()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInjectNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInjectNib()
    }
    
    // MARK: - Life cycle
    
    func commonInjectNib() {
        injectInterfaceFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: TextFieldSideBySideViewModelProtocol) {
        self.viewModel = viewModel
        
    }
    
    private func updateToPickerValidation(options: [String]?, dataSource: PickerDataSource, textField: TextField) -> String? {
        var text: String?
        
        if let options = options, !options.isEmpty {
            let option = dataSource.selectedOption
            textField.text = option
            text = option
        } else {
            text = textField.text
        }
        
        return text
    }
}

extension TextFieldSideBySideView {
    
    // MARK: - Actions
    
    @objc private func didChangeFirstTextField() {
        let text: String? = updateToPickerValidation(
            options: firstOptions,
            dataSource: firstPickerDataSource,
            textField: firstTextField
        )
        
        self.viewModel?.textDidChange(text: text, whichField: .first)
    }
    
    @objc private func didChangeSecondTextField() {
        let text: String? = updateToPickerValidation(
            options: secondOptions,
            dataSource: secondPickerDataSource,
            textField: secondTextField
        )
        
        self.viewModel?.textDidChange(text: text, whichField: .second)
    }
    
    // MARK: - View setup
    
    private func setup() {
        setupFirstLabel()
        setupSecondLabel()
        setupFirstTextField()
        setupSecondTextField()
    }
    
    private func setupFirstLabel() {
        firstLabel.font = .default(type: .bold, ofSize: 16)
        firstLabel.textColor = .blackColor
        firstLabel.numberOfLines = 1
    }
    
    private func setupSecondLabel() {
        secondLabel.font = .default(type: .bold, ofSize: 16)
        secondLabel.textColor = .blackColor
        secondLabel.numberOfLines = 1
    }
    
    private func setupFirstTextField() {
        firstTextField.addTarget(self, action: #selector(didChangeFirstTextField), for: .editingChanged)
    }
    
    private func setupSecondTextField() {
        secondTextField.addTarget(self, action: #selector(didChangeSecondTextField), for: .editingChanged)
    }
}
