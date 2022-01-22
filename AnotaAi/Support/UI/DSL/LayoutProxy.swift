//
//  LayoutProxy.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machdo on 09/07/20.
//  
//

import UIKit

class LayoutProxy {
    lazy var top = property(with: view.topAnchor)
    lazy var bottom = property(with: view.bottomAnchor)
    lazy var leading = property(with: view.leadingAnchor)
    lazy var trailing = property(with: view.trailingAnchor)

    lazy var width = propertyDimension(with: view.widthAnchor)
    lazy var height = propertyDimension(with: view.heightAnchor)

    lazy var centerX = property(with: view.centerXAnchor)
    lazy var centerY = property(with: view.centerYAnchor)

    private let view: UIView

    fileprivate init(view: UIView) {
        self.view = view
    }

    private func property<A: LayoutAnchor>(with anchor: A) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor)
    }

    private func propertyDimension<A: LayoutDimension>(with anchor: A) -> LayoutDimensionProperty<A> {
        return LayoutDimensionProperty(anchor: anchor)
    }

    func edges(to view: UIView, constant: CGFloat = 0) {
        top.equal(view.safeAreaLayoutGuide.topAnchor, constant: constant)
        bottom.equal(view.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
        leading.equal(view.safeAreaLayoutGuide.leadingAnchor, constant: constant)
        trailing.equal(view.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
    }
}

extension UIView {
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
}
