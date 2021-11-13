//
//  AddToCommandViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

protocol AddToCommandProtocol: AddToCommandViewModelProtocol {
    var onFailureAddToCommand: ((String) -> Void)? { get set }
    var onSuccessAddToCommand: (() -> Void)? { get set }
}

class AddToCommandViewModel {
    
    // MARK: - Public properties
    
    var onFailureAddToCommand: ((String) -> Void)?
    var onSuccessAddToCommand: (() -> Void)?
    var onAddOneMoreFood: ((Bool, [FoodCardCellViewModelProtocol]?) -> Void)?
    var onChangeValues: (() -> Void)?
    
    // MARK: - Private properties
    
    private var food: Food?
    private let foods: [Food?]
    private var item = Item()
    private var session: PersonSession?
    private let currentPrice: Double?
    private let addToCommandUseCase: AddToCommandUseCaseProtocol
    
    // MARK: - Init
    
    init(food: Food?, foods: [Food?], addToCommandUseCase: AddToCommandUseCaseProtocol, session: PersonSession?) {
        self.food = food
        self.foods = foods
        self.session = session
        self.addToCommandUseCase = addToCommandUseCase
        currentPrice = food?.price
        item.value = self.food?.price ?? 0.0
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
            self?.item.howMany = count
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
        item.value.localizedCurrency()
    }
    
    // MARK: - Action
    
    func didAddToCommand() {
        guard item.isHalf && item.otherFood != nil || !item.isHalf else {
            onFailureAddToCommand?("other_food_nil_error".localize(.error))
            return
        }
        
        addToCommand()
    }
    
    // MARK: - Requests
    
    private func addToCommand() {
        guard let person = session, let tableId = person.tableId, let token = person.token else { return }
        addToCommandUseCase.execute(
            item: item,
            ids: [tableId, token],
            success: { [weak self] in
                self?.onSuccessAddToCommand?()
            }, failure: { [weak self] error in
                self?.onFailureAddToCommand?(error)
            }
        )
    }
    
    // MARK: - Updates
    
    private func updateHalfText(_ text: String) {
        switch text {
        case "Metade":
            onAddOneMoreFood?(true, generateViewModels())
            item.isHalf = true
        case "Inteira":
            onAddOneMoreFood?(false, nil)
            item.isHalf = false
        default: return
        }
        updateTotalValue()
    }
    
    private func updateSizeText(_ text: String) {
        guard item.size != text else { return }
        item.size = text
        updateTotalValue()
    }
    
    private func updateObservationText(_ text: String?) {
        item.observation = text ?? ""
    }
    
    private func updateOtherFood(_ food: Food?) {
        guard let food = food else { return }
        item.otherFood = food
        updateTotalValue()
    }
    
    private func updateTotalValue() {
        guard let currentFoodPrice = currentPrice else { return }
        let priceDivided = currentFoodPrice / 2
        
        isHalfValidation(divided: priceDivided, price: currentFoodPrice)
        sizeValidation()
        
        guard let otherFoodValue = selectOtherFoodValidation() else { return }

        item.name = "\(food?.name ?? "") e \(item.otherFood?.name ?? "")"
        let total = item.value + otherFoodValue
        item.value = total * Double(item.howMany)
        onChangeValues?()
    }
}

// MARK: - Validations

extension AddToCommandViewModel {
    private func isHalfValidation(divided: Double, price: Double) {
        if item.isHalf {
            self.food?.price = divided
            item.value = divided
        } else {
            food?.price = price
            item.value = price
            item.otherFood = nil
        }
    }
    
    private func sizeValidation() {
        switch item.size {
            case "M": item.value = item.value
            case "G":
                item.value += 10
                food?.price += 10
            default: return
        }
    }
    
    private func selectOtherFoodValidation() -> Double? {
        guard let otherFoodValue = item.otherFood?.price else {
            item.value = item.value * Double(item.howMany)
            onChangeValues?()
            return nil
        }
        
        return otherFoodValue
    }
}
