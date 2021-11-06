//
//  AddToCommandViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

protocol AddToCommandProtocol: AddToCommandViewModelProtocol {
    
}

class AddToCommandViewModel {
    
    // MARK: - Public properties
    
    var onAddOneMoreFood: ((Bool) -> Void)?
    
    // MARK: - Private properties
    
    private let food: Food?
    
    // MARK: - Init
    
    init(food: Food?) {
        self.food = food
    }
}

extension AddToCommandViewModel: AddToCommandProtocol {
    
    var fieldSideBySideViewModel: TextFieldSideBySideViewModelProtocol {
        TextFieldSideBySideViewModelViewModel(onChangeFirstTextField: self.updateHalfText(_:), onChangeSecondTextField: self.updateSizeText(_:))
    }
    
    var fieldViewViewModel: TextFieldViewModelProtocol {
        TextFieldViewModel(onChangeTextFieldValue: self.updateObservationText(_:))
    }
    
    var url: URL? {
        URL(string: food?.preview ?? "")
    }
    
    var name: String? {
        food?.name
    }
    
    var description: String? {
        food?.description
    }
    
    var serves: Int? {
        food?.serves
    }
    
    var price: String? {
        food?.price.localizedCurrency()
    }
    
    // MARK: - Updates
    
    private func updateHalfText(_ text: String) {
        switch text {
        case "Metade": onAddOneMoreFood?(true)
        case "Inteira": onAddOneMoreFood?(false)
        default: return
        }
    }
    
    private func updateSizeText(_ text: String) {
        print(text)
    }
    
    private func updateObservationText(_ text: String?) {
        print(text)
    }
}
