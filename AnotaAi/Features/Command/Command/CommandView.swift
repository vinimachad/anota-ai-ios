//
//  CommandView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation

import UIKit

protocol CommandViewModelProtocol {
    var onChangeSections: (([TableSectionProtocol]) -> Void)? { get set }
}

class CommandView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private properties
    
    private(set) var viewModel: CommandViewModelProtocol?
    private var tableViewDataSource = TableViewDataSource()
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: CommandViewModelProtocol) {
        self.viewModel = viewModel
        
        self.viewModel?.onChangeSections = { [weak self] sections in
            self?.tableViewDataSource.sections = sections
        }
    }
}

// MARK: - View setup

extension CommandView {
    private func setup() {
        
    }
}

