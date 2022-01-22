//
//  TextFieldViewModel.swift
//  ExHotels
//
//  Created by Vinicius Galhardo Machado on 03/11/21.
//

import Foundation

class TextFieldViewModel {
    
    // MARK: - Private properties
    
    private var onChangeTextFieldValue: ((String?) -> Void)?
    
    // MARK: - Init
    
    init(onChangeTextFieldValue: ((String?) -> Void)?) {
        self.onChangeTextFieldValue = onChangeTextFieldValue
    }
}

extension TextFieldViewModel: TextFieldViewModelProtocol {

    // MARK: - Updates

    func didChange(_ text: String?) {
        onChangeTextFieldValue?(text)
    }
}
