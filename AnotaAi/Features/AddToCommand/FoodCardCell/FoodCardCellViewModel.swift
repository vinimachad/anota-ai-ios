//
//  FoodCarCellViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 06/11/21.
//

import Foundation

class FoodCardCellViewModel {
    
    // MARK: - Public properties
    
    var stringUrl: String?
    var name: String?
    var description: String?
    var pricing: Double?
    
    var onSelect: ((Food?) -> Void)?
    
    // MARK: - Init
    
    internal init(
        stringUrl: String? = nil,
        name: String? = nil,
        description: String? = nil,
        pricing: Double? = nil,
        onSelect: ((Food?) -> Void)?
    ) {
        self.stringUrl = stringUrl
        self.name = name
        self.description = description
        self.pricing = pricing
        self.onSelect = onSelect
    }
}

extension FoodCardCellViewModel: FoodCardCellViewModelProtocol {
    
    var url: URL? {
        guard let stringUrl = stringUrl else { return nil }
        return URL(string: stringUrl)
    }
    
    var price: String? {
        pricing?.localizedCurrency()
    }
    
    func didSelect(_ food: Food?) {
        onSelect?(food)
    }
}
