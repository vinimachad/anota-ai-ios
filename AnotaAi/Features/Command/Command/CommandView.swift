//
//  CommandView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 13/11/21.
//

import Foundation

import UIKit

protocol CommandViewModelProtocol {
    
}

class CommandView: UIView {
    
    // MARK: - UI Components
    
    
    // MARK: - Private properties
    
    private(set) var viewModel: CommandViewModelProtocol?
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: CommandViewModelProtocol) {
        self.viewModel = viewModel
        
    }
}

// MARK: - View setup

extension CommandView {
    private func setup() {
        
    }
}

