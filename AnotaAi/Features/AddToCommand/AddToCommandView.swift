//
//  AddToCommandView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

import UIKit

protocol AddToCommandViewModelProtocol {
    
}

class AddToCommandView: UIView {
    
    // MARK: - UI Components
    
    
    // MARK: - Private properties
    
    private(set) var viewModel: AddToCommandViewModelProtocol?
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: AddToCommandViewModelProtocol) {
        self.viewModel = viewModel
        
    }
}

// MARK: - View setup

extension AddToCommandView {
    private func setup() {
        
    }
}

