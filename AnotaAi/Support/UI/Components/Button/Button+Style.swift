//
//  Button+Style.swift
//  ExHotelsOffice
//
//  Created by Vinicius Galhardo Machado on 22/09/21.
//

import UIKit

extension Button {
    
    enum Style {
        case `default`
        
        var titleColor: UIColor {
            switch self {
            case .default:
                return .white
            }
        }
        
        var disableBackgroundColor: UIColor {
            switch self {
            case .default: return .disabledButtonColor
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .default: return .primaryColor
            }
        }
    }
}
