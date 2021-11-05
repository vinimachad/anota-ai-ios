//
//  MenuView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

import UIKit

protocol MenuViewModelProtocol {
    
}

class MenuView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var titleView: TitleView!
    @IBOutlet private weak var tablesView: UITableView!
    
    // MARK: - Private properties
    
    private(set) var viewModel: MenuViewModelProtocol?
    private var tableViewDataSource = TableViewDataSource()
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: MenuViewModelProtocol) {
        self.viewModel = viewModel
        tableViewDataSource.sections = []
    }
}

// MARK: - View setup

extension MenuView {
    
    private func setup() {
        setupTitleView()
    }
    
    private func setupTitleView() {
        titleView.title = "screen_title".localize(.restaurantMenu)
    }
    
    private func setupTableView() {
        tableViewDataSource.tableView = tablesView
    }
}

