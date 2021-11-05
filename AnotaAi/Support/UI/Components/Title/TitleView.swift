//
//  TitleView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 09/10/21.
//

import Foundation
import UIKit

class TitleView: UIView, NibLoadable {
    
    // MARK: - UI Components
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    // MARK: - Public properties
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set {
            subtitleLabel.text = newValue
            subtitleLabel.isHidden = (newValue ?? "").isEmpty
        }
    }
    
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
}

// MARK: - View setup

extension TitleView {
    private func setup() {
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .default(type: .bold, ofSize: 24)
        titleLabel.textColor = .blackColor
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.font = .default(type: .regular, ofSize: 16)
        subtitleLabel.textColor = .lightGrayOneColor
        subtitleLabel.isHidden = true
    }
}
