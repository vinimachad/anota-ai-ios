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
    var onChangeValues: (() -> Void)?
    
    // MARK: - Private properties
    
    private var food: Food?
    private let foods: [Food?]
    private var commandItem = CommandItem()
    private let currentPrice: Double?
    
    // MARK: - Init
    
    init(food: Food?, foods: [Food?]) {
        self.food = food
        self.foods = foods
        currentPrice = food?.price
        commandItem.value = self.food?.price ?? 0.0
    }
    
    private func generateViewModels() -> [FoodCardCellViewModelProtocol] {
        guard let foodId = food?.id else { return [] }
        
        let differentViewModels = foods.filter {
            guard let id = $0?.id else { return false }
            return id != foodId
        }
        
        return differentViewModels.map {
            FoodCardCellViewModel(
                id: $0?.id,
                stringUrl: $0?.preview,
                name: $0?.name,
                description: $0?.description,
                pricing: $0?.price,
                serves: $0?.serves,
                onSelect: self.updateOtherFood(_:)
            )
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
    
    var counterViewModel: CounterViewModelProtocol {
        CounterViewModel(onUpdateCountValue: { [weak self] count in
            self?.commandItem.howMany = count
        })
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
    
    var total: String? {
        commandItem.value.localizedCurrency()
    }
    
    // MARK: - Updates
    
    private func updateHalfText(_ text: String) {
        switch text {
        case "Metade":
            onAddOneMoreFood?(true, generateViewModels())
            commandItem.isHalf = true
            updateTotalValue()
        case "Inteira":
            onAddOneMoreFood?(false, nil)
            commandItem.isHalf = false
        default: return
        }
    }
    
    private func updateSizeText(_ text: String) {
        commandItem.size = text
    }
    
    private func updateObservationText(_ text: String?) {
        commandItem.observation = text ?? ""
    }
    
    private func updateOtherFood(_ food: Food?) {
        guard let food = food else { return }
        commandItem.otherFood = food
        updateTotalValue()
    }
    
    private func updateTotalValue() {
        guard let currentFoodPrice = currentPrice else { return }
        
        let priceDivided = currentFoodPrice / 2
        self.food?.price = priceDivided
        commandItem.value = priceDivided
        
        guard let otherFoodValue = commandItem.otherFood?.price else {
            onChangeValues?()
            return
        }
        
        let total = priceDivided + otherFoodValue
        commandItem.value = total
        onChangeValues?()
    }
}
