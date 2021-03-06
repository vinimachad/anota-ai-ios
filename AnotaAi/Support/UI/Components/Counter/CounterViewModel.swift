//
//  CounterViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 07/11/21.
//

import Foundation

class CounterViewModel {
    
    enum Counter {
        case sum
        case sub
    }
    
    // MARK: - Public properties
    
    var onChangeCount: ((String) -> Void)?
    
    var counter: Int = 1 {
        didSet {
            onChangeCount?(String(counter))
            onUpdateCountValue?(counter)
        }
    }
    
    // MARK: - Private properties
    
    private var onUpdateCountValue: ((Int) -> Void)?
    
    // MARK: - Init
    
    init(onUpdateCountValue: ((Int) -> Void)?) {
        self.onUpdateCountValue = onUpdateCountValue
    }
    
    private func subValidation() {
        if counter > 1 {
            counter -= 1
        }
    }
}

extension CounterViewModel: CounterViewModelProtocol {
    
    func didIncrement(_ type: Counter) {
        switch type {
            case .sum: counter += 1
            case .sub: subValidation()
        }
    }
}
