//
//  String+NSMutableAttributed.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 10/11/21.
//

import UIKit

extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(.foregroundColor, value: color, range: range)
    }
    
    func setFont(font: UIFont, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(.font, value: font, range: range)
    }
}
