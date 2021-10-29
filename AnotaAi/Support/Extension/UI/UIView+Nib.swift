//
//  UIView+Nib.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 16/08/21.
//

import UIKit

extension UIView {
    static func loadNib(name: String? = nil) -> Self {
        let nibName = name ?? String(describing: self)
        
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("could not load (nibName) as xib")
        }
        
        return view
    }
}
