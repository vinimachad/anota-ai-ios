//
//  Images.swift
//  AnotaAi
//
//  Created by Vincius Galhardo Machado on 16/08/21.
//

import UIKit

extension UIImage {
    
    enum Icons {
        
        static var recipt: UIImage {
            UIImage(named: "ic_comanda") ?? UIImage()
        }
        
        static var home: UIImage {
            UIImage(named: "ic_home") ?? UIImage()
        }
        
        static var user: UIImage {
            UIImage(named: "ic_user") ?? UIImage()
        }
    }
}
