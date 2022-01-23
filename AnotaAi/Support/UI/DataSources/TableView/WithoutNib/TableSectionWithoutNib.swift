//
//  TableSectionWithoutNib.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 23/01/22.
//

import Foundation
import Reusable

protocol TableSectionWithoutNibDelegate: AnyObject {
    func didSelect(item: Any, row: Int?)
}

class TableSectionWithoutNib<Cell: UITableViewCell & TableViewWithoutNibProtocol>: TableSectionWithoutNibProtocol {
    
    private var viewModels: [Cell.ViewModel]
    private weak var delegate: TableSectionWithoutNibDelegate?
    
    init(items: [Cell.ViewModel] = [], delegate: TableSectionWithoutNibDelegate? = nil) {
        self.viewModels = items
        self.delegate = delegate
    }
    
    func registerCell(tableView: UITableView?) {
        tableView?.registerWithoutNib(Cell.self)
    }
    
    var cellType: UITableViewCell.Type {
        Cell.self
    }
    
    var itemsCount: Int {
        return viewModels.count
    }
    
    func bindCell(cell: UITableViewCell, at row: Int) {
        if let cell = cell as? Cell, row < itemsCount {
            cell.bindIn(viewModel: viewModels[row])
        }
    }
    
    func didSelectAt(row: Int) {
        guard row < viewModels.count else { return }
        delegate?.didSelect(item: viewModels[row], row: row)
    }
}
