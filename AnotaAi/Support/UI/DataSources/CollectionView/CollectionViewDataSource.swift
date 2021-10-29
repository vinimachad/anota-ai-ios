//
//  CollectionViewDataSource.swift
//  R6Stats
//
//  Created by Vinicius Galhardo Machado on 30/09/21.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var scrollDelegate: UIScrollViewDelegate?
    
    var collectionView: UICollectionView? {
        didSet {
            collectionView?.delegate = self
            collectionView?.dataSource = self
            registerNibs()
        }
    }
    
    var sections: [CollectionSectionProtocol] = [] {
        didSet {
            collectionView?.reloadData()
            registerNibs()
        }
    }
    
    private func registerNibs() {
        for section in sections {
            collectionView?.registerNib(section.cellType)
        }
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let cell = collectionView.dequeueReusableCell(for: indexPath, type: section.cellType)
        section.bindCell(cell: cell, at: indexPath.item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].didSelectAt(row: indexPath.row)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll?(scrollView)
    }
}
