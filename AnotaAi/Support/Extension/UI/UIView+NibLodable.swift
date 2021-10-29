//
//  UIView+NibLodable.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 17/08/21.
//

import UIKit

private class NibLoadableViewManager {
    fileprivate static var cache: [String: UINib] = [:]
}

protocol NibLoadable {
    var nibName: String { get }
    var contentView: UIView? { get }
}

extension NibLoadable where Self: UIView {
    
    var nibName: String {
        return "\(type(of: self))".components(separatedBy: ".").last ?? ""
    }
    
    func injectInterfaceFromNib() {
        let nib: UINib
        
        if let cached = NibLoadableViewManager.cache[self.nibName] {
            nib = cached
        } else {
            let bundle = Bundle(for: type(of: self))
            nib = UINib(nibName: self.nibName, bundle: bundle)
            NibLoadableViewManager.cache[self.nibName] = nib
        }
        
        nib.instantiate(withOwner: self, options: nil)
        
        if let contentView = self.contentView {
            contentView.backgroundColor = .clear
            contentView.clipsToBounds = true
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            contentView.translatesAutoresizingMaskIntoConstraints = true
            
            addSubview(contentView)
        } else {
            print("Can't load nib named \(self.nibName)!")
        }
    }
}
