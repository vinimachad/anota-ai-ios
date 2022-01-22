//
//  TextField+Toolbar.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 25/07/20.
//  
//

import UIKit

extension TextField {

    func createToolbar(title: String, selector: Selector = #selector(didTapToolBarDone)) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolBar.isTranslucent = false
        toolBar.tintColor = .black
        toolBar.barStyle = UIBarStyle.default

        let titleButton = createPlaceholderTitle()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: title.uppercased(), style: .done, target: self, action: selector)
        
        toolBar.setItems([spaceButton, titleButton, spaceButton, doneButton], animated: true)
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }

    @objc private func didTapToolBarDone() {
        resignFirstResponder()
        sendActions(for: .editingChanged)
    }

    private func createPlaceholderTitle() -> UIBarButtonItem {
        let label = UILabel()
        label.text = self.placeholder
        label.textColor = .blackColor
        label.font = UIFont.default(type: .bold, ofSize: 16)
        label.textAlignment = .center
        return UIBarButtonItem(customView: label)
    }
}
