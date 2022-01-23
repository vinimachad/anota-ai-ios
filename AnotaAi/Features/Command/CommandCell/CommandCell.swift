//
//  CommandCell.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 22/01/22.
//

import Foundation
import UIKit
import Reusable
import SnapKit

protocol CommandCellViewModelProtocol: TablesWithoutViewModelProtocol {
    var title: String? { get }
    var subtitle: String? { get }
    var status: Stats? { get }
}

class CommandCell: UITableViewCell, TableViewWithoutNibProtocol {    
    
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
        statusLabel.text = viewModel.status?.title
        statusLabel.textColor = viewModel.status?.textColor
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
        titleLabel.font = .default(type: .regular, ofSize: 16)
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
        layoutIfNeeded()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 4
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 0.16
    }
}

// MARK: - Setup constraints

extension CommandCell {
    
    private func setupConstraints() {
        viewHierarchy()
        
        containerView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leadingMargin)
            $0.trailing.equalTo(self.snp.trailingMargin)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(snp.bottomMargin)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.top.equalTo(containerView.snp.topMargin)
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-8)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(statusLabel.snp.top).offset(-8)
        }
        
        statusLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-16)
        }
    }
    
    private func viewHierarchy() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(statusLabel)
        addSubview(containerView)
    }
}
