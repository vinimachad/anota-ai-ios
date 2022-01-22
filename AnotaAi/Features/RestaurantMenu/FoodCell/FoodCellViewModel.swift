//
//  FoodCellViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

class FoodCellViewModel {
    
    // MARK: - Public properties
    
    var stringUrl: String?
    var name: String?
    var description: String?
    var serves: Int?
    var pricing: Double?
    
    var onSelect: ((Food?) -> Void)?
    
    // MARK: - Init
    
    internal init(
        stringUrl: String? = nil,
        name: String? = nil,
        description: String? = nil,
        serves: Int? = nil,
        pricing: Double? = nil,
        onSelect: ((Food?) -> Void)?
    ) {
        self.stringUrl = stringUrl
        self.name = name
        self.description = description
        self.serves = serves
        self.pricing = pricing
        self.onSelect = onSelect
    }
}

extension FoodCellViewModel: FoodCellViewModelProtocol {
    
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
