//
//  Fonts.swift
//  AnotaAi
//
//  Created by Victor Kazuo on 16/08/21.
//

import UIKit

extension UIFont {
    
    enum FontType: String {
        case semiBold = "Gilroy-SemiBold"
        case regular = "Gilroy-Regular"
        case bold = "Gilroy-Bold"
        case black = "Gilroy-Black"
    }
    
    static func `default`(type: FontType, ofSize size: CGFloat = UIFont.labelFontSize) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            fatalError("Font \(type.rawValue) is not in the project")
        }
        
        return font
    }
}
