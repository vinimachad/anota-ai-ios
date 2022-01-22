//
//  PickerDataSource.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 29/07/20.
//  
//

import UIKit

class PickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

    var picker: UIPickerView? {
        didSet {
            picker?.delegate = self
            picker?.dataSource = self
        }
    }

    var options: [String] = [] {
        didSet {
            selectedOption = options.first
            picker?.reloadAllComponents()
        }
    }

    var selectedOption: String? {
        didSet {
            guard let index = options.firstIndex(where: { $0 == selectedOption }) else {
                return
            }
            picker?.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    var onSelectOption: ((String?) -> Void)?

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = .black
        label.text = options[row]
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < options.count else { return }
        selectedOption = options[row]
        onSelectOption?(selectedOption)
    }
}
