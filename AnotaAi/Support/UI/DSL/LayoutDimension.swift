//
//  LayoutDimension.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machdo on 09/07/20.
//  Copyright © 2020 Jera. All rights reserved.
//

import UIKit

protocol LayoutDimension: LayoutAnchor {
    func constraint(equalToConstant c: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant c: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutDimension: LayoutDimension { }

class LayoutDimensionProperty<Anchor: LayoutDimension>: LayoutProperty<Anchor> {

    func equalTo(_ constant: CGFloat) {
        let constraint = anchor.constraint(equalToConstant: constant)
        constraint.isActive = true
    }
}
