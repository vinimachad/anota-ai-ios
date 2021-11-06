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
    
    var onAddOneMoreFood: ((Bool, [FoodCardCellViewModelProtocol]?) -> Void)?
    
    // MARK: - Private properties
    
    private let food: Food?
    private let foods: [Food?]
    
    // MARK: - Init
    
    init(food: Food?, foods: [Food?]) {
        self.food = food
        self.foods = foods
    }
    
    private func generateViewModels() -> [FoodCardCellViewModelProtocol] {
        guard let foodId = food?.id else { return [] }
        
        let differentViewModels = foods.filter {
            guard let id = $0?.id else { return false }
            return id != foodId
        }
        
        return differentViewModels.map {
            FoodCardCellViewModel(stringUrl: $0?.preview, name: $0?.name, description: $0?.description, pricing: $0?.price, onSelect: { _ in })
        }
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
        case "Metade": onAddOneMoreFood?(true, generateViewModels())
        case "Inteira": onAddOneMoreFood?(false, nil)
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
