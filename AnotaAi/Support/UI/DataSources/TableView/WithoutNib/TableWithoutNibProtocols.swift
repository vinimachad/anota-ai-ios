//
//  TableWithoutNibProtocols.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 23/01/22.
//

import Foundation
import UIKit
import Reusable

protocol TableSectionWithoutNibProtocol {
    var itemsCount: Int { get }
    var cellType: UITableViewCell.Type { get }
    func bindCell(cell: UITableViewCell, at row: Int)
    func didSelectAt(row: Int)
    func registerCell(tableView: UITableView?)
}

extension TableSectionWithoutNibProtocol {
    
    func didSelectAt(row: Int) {
        
    }
}

protocol TablesWithoutViewModelProtocol { }

protocol TableViewWithoutNibProtocol: Reusable {
    associatedtype ViewModel = TablesWithoutViewModelProtocol
    func bindIn(viewModel: ViewModel)
}


