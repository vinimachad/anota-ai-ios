//
//  Alert.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado 3/11/2021
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if !actions.isEmpty {
            for action in actions {
                alert.addAction(action)
            }
            
        } else {
            let okAction = UIAlertAction(title: "ok".localize(.default), style: .default)
            alert.addAction(okAction)
        }
        
        present(alert, animated: true)
    }
    
    func showTextFieldAlert(title: String, message: String, placeholder: String? = "", completion: ((String?) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields?[0]
            completion?(textField?.text)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}
