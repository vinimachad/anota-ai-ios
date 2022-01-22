//
//  Double+Currency.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

extension Double {
    
    func localizedCurrency(locale: Locale = Locale(identifier: "pt_BR"),
                           withCurrencySymbol: Bool = true) -> String? {
        let numberFormatter = NumberFormatter.currencyFormatter(locale: locale, withCurrencySymbol: withCurrencySymbol)
        
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            return nil
        }
        return formattedNumber
    }
    
}

