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
    var value: String? { get }
    var size: String? { get }
    var nameClient: String? { get }
}

class CommandCell: UITableViewCell, TableViewWithoutNibProtocol {    
    
    // MARK: - UI Components
    
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var statusLabel = UILabel()
    private var containerView = UIView()
    private var sizeLabel = UILabel()
    private var valueLabel = UILabel()
    private var whoRequestLabel = UILabel()
    
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
        whoRequestLabel.text = "request_label".localize(.command, [viewModel.nameClient ?? ""])
        sizeLabel.text = "size_label".localize(.command, [viewModel.size ?? ""])
        updateValueLabel(viewModel.value ?? "")
        updateStatus(viewModel.status ?? Stats.waiting)
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
        setupSizeLabel()
        setupValueLabel()
        setupWhoRequestLabel()
    }
    
    private func setupWhoRequestLabel() {
        whoRequestLabel.font = .default(type: .regular, ofSize: 14)
        whoRequestLabel.textColor = .blackColor
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .default(type: .regular, ofSize: 16)
        titleLabel.textColor = .blackColor
        titleLabel.numberOfLines = 0
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .default(type: .regular, ofSize: 14)
        subtitleLabel.textColor = .grayColor
    }
    
    private func setupSizeLabel() {
        sizeLabel.numberOfLines = 0
        sizeLabel.font = .default(type: .regular, ofSize: 14)
        sizeLabel.textColor = . grayColor
    }
    
    private func setupValueLabel() {
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .greenColor
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
    
    private func updateValueLabel(_ total: String) {
        let text = "total_label".localize(.command, [total])
        let totalText = NSMutableAttributedString(string: text)
        totalText.setFont(font: .default(type: .regular, ofSize: 14), forText: text)
        totalText.setFont(font: .default(type: .bold, ofSize: 16), forText: total)
        valueLabel.attributedText = totalText
    }
    
    private func updateStatus(_ status: Stats) {
        let text = "stats_of_your_request_label".localize(.command, [status.title])
        let fullText = NSMutableAttributedString(string: text)
        fullText.setColor(color: .grayColor, forText: text)
        fullText.setColor(color: status.textColor, forText: status.title)
        statusLabel.attributedText = fullText
    }
}

// MARK: - Setup constraints

extension CommandCell {
    
    private func setupConstraints() {
        viewHierarchy()
        
        containerView.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leadingMargin)
            $0.trailing.equalTo(self.snp.trailingMargin)
            $0.top.equalTo(self.snp.top).offset(6)
            $0.bottom.equalTo(snp.bottomMargin)
        }
        
        whoRequestLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.top.equalTo(containerView.snp.topMargin)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-8)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(sizeLabel.snp.top).offset(-4)
        }
        
        sizeLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(statusLabel.snp.top).offset(-4)
        }
        
        statusLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(valueLabel.snp.top).offset(-12)
        }
        
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leadingMargin)
            $0.trailing.equalTo(containerView.snp.trailingMargin)
            $0.bottom.equalTo(containerView.snp.bottomMargin)
        }
    }
    
    private func viewHierarchy() {
        containerView.addSubview(whoRequestLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(sizeLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(valueLabel)
        addSubview(containerView)
    }
}
