//
//  UICollectionView+Reusable.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/09/21.
//

import UIKit

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: Bundle(for: type))
        self.register(nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, type: T.Type) -> T {
        let dequeueCell = self.dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath)
        
        guard let cell = dequeueCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(type.reuseIdentifier)")
        }
        return cell
    }
}
