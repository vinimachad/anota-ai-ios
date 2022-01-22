//
//  TextField+Picker.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 25/07/20.
//  
//

import UIKit

extension TextField {

    func createPicker(dataSource: PickerDataSource, toolbarTitle: String = "ok".localize(.default)) {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.setValue(UIColor.black, forKeyPath: "textColor")
        dataSource.picker = picker
        
        createToolbar(title: toolbarTitle)
        inputView = picker
    }
}
