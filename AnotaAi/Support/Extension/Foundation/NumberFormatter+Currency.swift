//
//  NumberFormatter+Currency.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

extension NumberFormatter {
    
    static func currencyFormatter(locale: Locale = Locale(identifier: "pt_BR"),
                                  withCurrencySymbol: Bool = true) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.currencySymbol = withCurrencySymbol ? nil : ""
        return formatter
    }
    
}
