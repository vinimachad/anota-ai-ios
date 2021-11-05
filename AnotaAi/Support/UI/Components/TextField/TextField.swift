//
//  TextField.swift
//  ExHotelsOffice
//
//  Created by Vinicius Galhardo Machado on 27/09/21.
//

import UIKit

class TextField: UITextField {

    var isHideOnReturn: Bool = true

    override var placeholder: String? {
        didSet {
            preparePlaceholder(placeholder)
        }
    }

    override weak open var delegate: UITextFieldDelegate? {
        get { return self._delegate }
        set {
            self._delegate = newValue
            super.delegate = self
        }
    }
    
    // MARK: - Private properties

    private weak var _delegate: UITextFieldDelegate?

    private let defaultMargin = CGFloat(8)
    private let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Rects
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return applyPaddingFor(bounds: bounds)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var viewRect = super.leftViewRect(forBounds: bounds)
        viewRect.origin.x += padding.left
        return viewRect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var viewRect = super.rightViewRect(forBounds: bounds)
        viewRect.origin.x -= padding.right
        return viewRect
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var viewRect = super.clearButtonRect(forBounds: bounds)
        viewRect.origin.x -= padding.right
        return viewRect
    }

    private func applyPaddingFor(bounds: CGRect) -> CGRect {
        var padding = self.padding

        let leftBounds = leftViewRect(forBounds: bounds)
        if leftBounds.width != 0 {
            padding.left += leftBounds.width + defaultMargin
        }

        let rightBounds = rightViewRect(forBounds: bounds)
        if rightBounds.width != 0 {
            padding.right += rightBounds.width + defaultMargin
        }

        let clearBounds = clearButtonRect(forBounds: bounds)
        if clearBounds.width != 0 && isEditing {
            padding.right += clearBounds.width + defaultMargin
        }

        return bounds.inset(by: padding)
    }
}

extension TextField {

    private func setup() {
        super.delegate = self

        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.borderColor = UIColor.lightGrayTwoColor.cgColor
        clearButtonMode = .whileEditing

        tintColor = .black
        font = UIFont.default(type: .semiBold, ofSize: 14)
    }
    
    private func preparePlaceholder(_ placeholder: String?) {
        guard let placeholder = placeholder else { return }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.default(type: .regular, ofSize: 14),
            .foregroundColor: UIColor.lightGrayOneColor
        ]

        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
}

extension TextField: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isHideOnReturn {
            resignFirstResponder()
        }
        return _delegate?.textFieldShouldReturn?(textField) ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        _delegate?.textFieldDidBeginEditing?(textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        _delegate?.textFieldDidEndEditing?(textField)
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return _delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return _delegate?.textFieldShouldEndEditing?(textField) ?? true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = self._delegate, delegate.responds(to: #selector(textField(_:shouldChangeCharactersIn:replacementString:))) {
            let delegateResponse = delegate.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)

            if let delegateResponse = delegateResponse, !delegateResponse {
                return false
            }
        }

        return true
    }
}
