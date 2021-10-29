//
//  CollectionSection.swift
//  R6Stats
//
//  Created by Vinicius Galhardo Machado on 30/09/21.
//

import UIKit

protocol CollectionSectionDelegate: AnyObject {
    func didSelect(item: Any)
}

class CollectionSection<Cell: UICollectionViewCell & CollectionViewProtocol>: CollectionSectionProtocol {
    
    private var items: [Cell.ViewModel]
    private weak var delegate: CollectionSectionDelegate?
    
    init(items: [Cell.ViewModel], delegate: CollectionSectionDelegate? = nil) {
        self.items = items
        self.delegate = delegate
    }
    
    var itemsCount: Int {
        return items.count
    }
    
    var cellType: UICollectionViewCell.Type {
        return Cell.self
    }
    
    func bindCell(cell: UICollectionViewCell, at row: Int) {
        if let cell = cell as? Cell, row < itemsCount {
            cell.bindIn(viewModel: items[row])
        }
    }
    
    func didSelectAt(row: Int) {
        guard row < items.count else { return }
        delegate?.didSelect(item: items[row])
    }
}
