//
//  TableProtocols.swift
//  app-template
//
//  Created by Vinicius Galhardo Machado on 25/04/21.
//

import UIKit

protocol TableSectionProtocol {
    var itemsCount: Int { get }
    var cellType: UITableViewCell.Type { get }
    func bindCell(cell: UITableViewCell, at row: Int)
    func didSelectAt(row: Int)
    
    func headerView() -> UIView?
    func headerHeight() -> CGFloat
}

extension TableSectionProtocol {
    
    func headerView() -> UIView? {
        return nil
    }
    
    func headerHeight() -> CGFloat {
        return 0
    }
    
    func didSelectAt(row: Int) {
        
    }
}

protocol TableViewModelProtocol { }

protocol TableViewProtocol {
    associatedtype ViewModel = TableViewModelProtocol
    func bindIn(viewModel: ViewModel)
}
