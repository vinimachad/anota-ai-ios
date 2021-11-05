//
//  LayoutAnchor.swift
//  Muvver
//
//  Created by mano on 09/07/20.
//  Copyright © 2020 Jera. All rights reserved.
//

import UIKit

protocol LayoutAnchor {
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor { }

class LayoutProperty<Anchor: LayoutAnchor> {

    let anchor: Anchor

    init(anchor: Anchor) {
        self.anchor = anchor
    }

    func equal(_ otherAnchor: Anchor, constant: CGFloat = 0) {
        let constraint = anchor.constraint(equalTo: otherAnchor, constant: constant)
        constraint.isActive = true
    }

    func greaterThanOrEqual(_ otherAnchor: Anchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
    }
}
