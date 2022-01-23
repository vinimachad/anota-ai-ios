//
//  CommandView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation
import UIKit

protocol CommandViewModelProtocol {
    var onChangeCommands: (([CommandCellViewModelProtocol]) -> Void)? { get set }
}

class CommandView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private(set) var viewModel: CommandViewModelProtocol?
    private var tableViewDataSource = TableViewDataSourceWithoutNib()
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: CommandViewModelProtocol) {
        self.viewModel = viewModel
        
        self.viewModel?.onChangeCommands = { [weak self] viewModels in
            self?.tableViewDataSource.sections = [TableSectionWithoutNib<CommandCell>(items: viewModels)]
        }
    }
}

// MARK: - View setup

extension CommandView {
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewDataSource.tableView = tableView
        tableView.separatorStyle = .none
    }
}
