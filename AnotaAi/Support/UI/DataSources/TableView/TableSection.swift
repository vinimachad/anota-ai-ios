//
//  TableSection.swift
//  app-template
//
//  Created by Vinicius Galhardo Machado on 25/04/21.
//

import UIKit

protocol TableSectionDelegate: AnyObject {
    func didSelect(item: Any)
}

class TableSection<Cell: UITableViewCell & TableViewProtocol>: TableSectionProtocol {
    
    private var items: [Cell.ViewModel]
    private weak var delegate: TableSectionDelegate?
    
    init(items: [Cell.ViewModel] = [], delegate: TableSectionDelegate? = nil) {
        self.items = items
        self.delegate = delegate
    }
    
    var itemsCount: Int {
        return items.count
    }
    
    var cellType: UITableViewCell.Type {
        return Cell.self
    }
    
    func bindCell(cell: UITableViewCell, at row: Int) {
        if let cell = cell as? Cell, row < itemsCount {
            cell.bindIn(viewModel: items[row])
        }
    }
    
    func didSelectAt(row: Int) {
        guard row < items.count else { return }
        delegate?.didSelect(item: items[row])
    }
}
