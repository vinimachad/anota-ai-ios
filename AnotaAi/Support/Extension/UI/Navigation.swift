//
//  Navigation.swift
//  AnotaAi
//
//  Created by Vitor Mesquita on 30/08/21.
//

import UIKit

extension UIViewController {
    
    func setTransparentNavigation() {
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        removeShadowLine()
    }
    
    func removeShadowLine() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
