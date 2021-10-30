//
//  Button.swift
//  ExHotelsOffice
//
//  Created by Vinicius Galhardo Machado on 22/09/21.
//

import UIKit

class Button: UIButton {
    
    // MARK: - Public properties
    
    override var isEnabled: Bool {
        didSet {
            setupBackgroundColorByState()
        }
    }
    
    var style: Style = .default {
        didSet {
            setupByStyle()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            updateButtonToLoading()
        }
    }
    
    var title: String? {
        get { titleLabel?.text }
        set {
            UIView.performWithoutAnimation {
                setTitle(newValue, for: .normal)
                setTitle(newValue, for: .disabled)
                layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

// MARK: - View Setup

extension Button {
    
    private func setup() {
        layer.cornerRadius = 8
        setupByStyle()
    }
    
    private func setupBackgroundColorByState() {
        self.backgroundColor = isEnabled ? style.backgroundColor : style.disableBackgroundColor
    }
    
    private func setupByStyle() {
        backgroundColor = style.backgroundColor
        setTitleColor(style.titleColor, for: .normal)
        setTitleColor(style.titleColor, for: .disabled)
        titleLabel?.font = .default(type: .bold, ofSize: 16)
    }
}

extension Button {

    private func updateButtonToLoading() {
        isUserInteractionEnabled = !isLoading
        setTitleColor(isLoading ? .clear : style.titleColor, for: .normal)
        setTitleColor(isLoading ? .clear : style.titleColor, for: .disabled)

        if isLoading {
            addLoading()
        } else {
            removeLoading()
        }
    }

    private func addLoading() {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.color = style.titleColor
        self.addSubview(indicator)

        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
        indicator.startAnimating()
    }

    private func removeLoading() {
        if let indicator = self.subviews.first(where: { $0 is UIActivityIndicatorView }) {
            indicator.removeFromSuperview()
        }
    }
}
