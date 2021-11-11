//
//  FoodCarCellViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 06/11/21.
//

import Foundation

class FoodCardCellViewModel {
    
    // MARK: - Public properties
    
    var id: String?
    var stringUrl: String?
    var name: String?
    var description: String?
    var pricing: Double?
    var serves: Int?
    
    var onSelect: ((Food?) -> Void)?
    
    // MARK: - Init
    
    internal init(
        id: String? = nil,
        stringUrl: String? = nil,
        name: String? = nil,
        description: String? = nil,
        pricing: Double? = nil,
        serves: Int?,
        onSelect: ((Food?) -> Void)?
    ) {
        self.id = id
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
    
    func didSelect() {
        guard
            let description = description,
            let name = name,
            let preview = stringUrl,
            let price = pricing,
            let serves = serves
        else { return }
        
        let food = Food(
            description: description,
            name: name,
            preview: preview,
            price: price,
            serves: serves
        )
        
        onSelect?(food)
    }
}
