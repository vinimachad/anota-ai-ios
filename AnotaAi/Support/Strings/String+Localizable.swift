//
//  String+Localizable.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 16/08/21.
//

import Foundation

enum LocalizableFiles: String {
    case `default` = "Default"
    case error = "Error"
    case welcome = "Welcome"
    case restaurantMenu = "RestaurantMenu"
    case home = "Home"
    case addToCommand = "AddToCommand"
}

extension String {
    
    private func localized(context: LocalizableFiles) -> String {
        return NSLocalizedString(self, tableName: context.rawValue, value: "", comment: "")
    }
    
    private func localizedWithArgs(context: LocalizableFiles, _ args: [CVarArg]) -> String {
        return String(format: localized(context: context), arguments: args)
    }
    
    func localize(_ context: LocalizableFiles, _ args: [CVarArg] = []) -> String {
        guard !args.isEmpty else {
            return localized(context: context)
        }
        
        return localizedWithArgs(context: context, args)
    }
}
