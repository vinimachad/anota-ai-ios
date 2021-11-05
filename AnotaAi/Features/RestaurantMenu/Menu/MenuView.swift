//
//  MenuView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

import UIKit

protocol MenuViewModelProtocol {
    var name: String? { get }
    var onChangeFoods: (([FoodCellViewModelProtocol]) -> Void)? { get set }
    func didSelect(viewModel: FoodCellViewModelProtocol)
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
        self.titleView.title = "hello_title".localize(.restaurantMenu, [viewModel.name ?? ""])
        
        self.viewModel?.onChangeFoods = { [weak self] viewModels in
            self?.tableViewDataSource.sections = [TableSection<FoodCell>(items: viewModels, delegate: self)]
        }
    }
}

// MARK: - View setup

extension MenuView {
    
    private func setup() {
        setupTitleView()
        setupTableView()
    }
    
    private func setupTitleView() {
        titleView.subtitle = "make_request_label".localize(.restaurantMenu)
    }
    
    private func setupTableView() {
        tableViewDataSource.tableView = tablesView
        tablesView.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
}

extension MenuView: TableSectionDelegate {
    
    func didSelect(item: Any) {
        guard let viewModel = item as? FoodCellViewModelProtocol else { return }
        self.viewModel?.didSelect(viewModel: viewModel)
    }
}
