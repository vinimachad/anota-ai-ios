//
//  CounterView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 07/11/21.
//

import Foundation
import UIKit

protocol CounterViewModelProtocol {
    var counter: Int { get }
    var onChangeCount: ((String) -> Void)? { get set }
    func didIncrement(_ type: CounterViewModel.Counter)
}

class CounterView: UIView, NibLoadable {
    
    // MARK: - Public properties
    
    // MARK: - UI Components
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet private weak var subtractButton: UIButton!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var sumButton: UIButton!
    
    // MARK: - Private properties
    
    private(set) var viewModel: CounterViewModelProtocol?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInjectNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInjectNib()
    }
    
    // MARK: - Life cycle
    
    func commonInjectNib() {
        injectInterfaceFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: CounterViewModelProtocol) {
        self.viewModel = viewModel
        self.countLabel.text = String(viewModel.counter)
        self.viewModel?.onChangeCount = { [weak self] count in
            self?.countLabel.text = count
            self?.subtractButton.isEnabled = Int(count) ?? 1 > 1 ? true : false
        }
    }
}

extension CounterView {
    
    // MARK: - Actions
    
    @objc private func didSubtractCount() {
        viewModel?.didIncrement(.sub)
    }
    
    @objc private func didSumCount() {
        viewModel?.didIncrement(.sum)
    }
    
    // MARK: - View setup
    
    private func setup() {
        setupSubtractButton()
        setupCountLabel()
        setupSumButton()
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGrayTwoColor.cgColor
        layer.cornerRadius = 8
    }
    
    private func setupSubtractButton() {
        subtractButton.isEnabled = false
        subtractButton.setTitle("-", for: .normal)
        subtractButton.setTitleColor(.primaryColor, for: .normal)
        subtractButton.setTitleColor(.lightGrayOneColor, for: .disabled)
        subtractButton.titleLabel?.font = .default(type: .bold, ofSize: 16)
        subtractButton.addTarget(self, action: #selector(didSubtractCount), for: .touchUpInside)
    }
    
    private func setupCountLabel() {
        countLabel.font = .default(type: .regular, ofSize: 16)
        countLabel.textColor = .grayColor
    }
    
    private func setupSumButton() {
        sumButton.setTitle("+", for: .normal)
        sumButton.setTitleColor(.primaryColor, for: .normal)
        sumButton.setTitleColor(.lightGrayOneColor, for: .disabled)
        sumButton.titleLabel?.font = .default(type: .bold, ofSize: 16)
        sumButton.addTarget(self, action: #selector(didSumCount), for: .touchUpInside)
    }
    
}
