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
        updateHalfText("Inteira")
        updateSizeText("M")
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
                pricing: ($0?.price ?? 0.0) / 2,
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
            self?.updateTotalValue()
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
    
    // MARK: - Action
    
    func didAddToCommand() {
        
    }
    
    // MARK: - Updates
    
    private func updateHalfText(_ text: String) {
        switch text {
        case "Metade":
            onAddOneMoreFood?(true, generateViewModels())
            commandItem.isHalf = true
        case "Inteira":
            onAddOneMoreFood?(false, nil)
            commandItem.isHalf = false
        default: return
        }
        updateTotalValue()
    }
    
    private func updateSizeText(_ text: String) {
        guard commandItem.size != text else { return }
        commandItem.size = text
        updateTotalValue()
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
        
        isHalfValidation(divided: priceDivided, price: currentFoodPrice)
        sizeValidation()
        
        guard let otherFoodValue = selectOtherFoodValidation() else { return }

        let total = commandItem.value + otherFoodValue
        commandItem.value = total * Double(commandItem.howMany)
        onChangeValues?()
    }
}

// MARK: - Validations

extension AddToCommandViewModel {
    private func isHalfValidation(divided: Double, price: Double) {
        if commandItem.isHalf {
            self.food?.price = divided
            commandItem.value = divided
        } else {
            food?.price = price
            commandItem.value = price
            commandItem.otherFood = nil
        }
    }
    
    private func sizeValidation() {
        switch commandItem.size {
            case "M": commandItem.value = commandItem.value
            case "G":
                commandItem.value += 10
                food?.price += 10
            default: return
        }
    }
    
    private func selectOtherFoodValidation() -> Double? {
        guard let otherFoodValue = commandItem.otherFood?.price else {
            commandItem.value = commandItem.value * Double(commandItem.howMany)
            onChangeValues?()
            return nil
        }
        
        return otherFoodValue
    }
}
