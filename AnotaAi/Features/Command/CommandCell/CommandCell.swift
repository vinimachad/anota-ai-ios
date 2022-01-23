//
//  CommandCell.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 22/01/22.
//

import Foundation
import UIKit
import Reusable

protocol CommandCellViewModelProtocol: TablesViewModelProtocol {
    var title: String? { get }
    var subtitle: String? { get }
    var onUpdateStats: ((Stats) -> Void)? { get set }
}

class CommandCell: UITableViewCell, Reusable, TableViewProtocol {    
    
    // MARK: - UI Components
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var statusLabel = UILabel()
    private var containerView = UIView()
    
    // MARK: - Private properties
    
    private var viewModel: CommandCellViewModelProtocol?
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: CommandCellViewModelProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        self.viewModel?.onUpdateStats = { [weak self] stats in
            self?.statusLabel.text = stats.title
            self?.statusLabel.textColor = stats.textColor
        }
    }
}

// MARK: - Setup view

extension CommandCell {
    
    private func setup() {
        setupConstraints()
        setupTitleLabel()
        setupSubtitleLabel()
        setupStatusLabel()
        setupContainerView()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .default(type: .regular, ofSize: 14)
        titleLabel.textColor = .blackColor
        titleLabel.numberOfLines = 0
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .default(type: .regular, ofSize: 14)
        subtitleLabel.textColor = .lightGrayOneColor
    }
    
    private func setupStatusLabel() {
        statusLabel.numberOfLines = 0
        statusLabel.font = .default(type: .regular, ofSize: 14)
    }
    
    private func setupContainerView() {
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = .zero;
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.16
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius:containerView.layer.cornerRadius).cgPath
    }
}

// MARK: - Setup constraints

extension CommandCell {
    
    private func setupConstraints() {
        viewHierarchy()
        
        containerView.layout {
            $0.leading.equal(self.leftAnchor, constant: 16)
            $0.trailing.equal(self.rightAnchor, constant: -16)
            $0.top.equal(self.topAnchor)
            $0.bottom.equal(self.bottomAnchor, constant: -16)
        }
        
        titleLabel.layout {
            $0.leading.equal(containerView.leftAnchor, constant: 16)
            $0.trailing.equal(containerView.rightAnchor, constant: -16)
            $0.top.equal(containerView.topAnchor, constant: 16)
            $0.bottom.equal(subtitleLabel.topAnchor, constant: -8)
        }
        
        subtitleLabel.layout {
            $0.leading.equal(containerView.leftAnchor, constant: 16)
            $0.trailing.equal(containerView.rightAnchor, constant: -16)
            $0.bottom.equal(statusLabel.topAnchor, constant: -8)
        }
        
        statusLabel.layout {
            $0.leading.equal(containerView.leftAnchor, constant: 16)
            $0.trailing.equal(containerView.rightAnchor, constant: -16)
            $0.bottom.equal(containerView.bottomAnchor, constant: -16)
        }
    }
    
    private func viewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(statusLabel)
    }
}
