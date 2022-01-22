//
//  TextFieldSideBySideViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

class TextFieldSideBySideViewModelViewModel {
    
    enum WhichField {
        case first
        case second
    }
    
    // MARK: - Private properties
    
    private var onChangeFirstTextField: ((String) -> Void)?
    private var onChangeSecondTextField: ((String) -> Void)?
    
    // MARK: - Init
    
    internal init(onChangeFirstTextField: ((String) -> Void)? = nil, onChangeSecondTextField: ((String) -> Void)? = nil) {
        self.onChangeFirstTextField = onChangeFirstTextField
        self.onChangeSecondTextField = onChangeSecondTextField
    }
    
}

extension TextFieldSideBySideViewModelViewModel: TextFieldSideBySideViewModelProtocol {
    func textDidChange(text: String?, whichField: WhichField) {
        switch whichField {
        case .first:
            onChangeFirstTextField?(text ?? "")
        case .second:
            onChangeSecondTextField?(text ?? "")
        }
    }
}
