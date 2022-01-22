//
//  UIImageView+Url.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Kingfisher

extension UIImageView {
    
    func imageBy(url: URL?, placeholder: UIImage? = nil) {
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
