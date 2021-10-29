//
//  CollectionProtocol.swift
//  R6Stats
//
//  Created by Vinicius Galhardo Machado on 30/09/21.
//

import UIKit

protocol CollectionSectionProtocol {
    var itemsCount: Int { get }
    var cellType: UICollectionViewCell.Type { get }
    
    func bindCell(cell: UICollectionViewCell, at row: Int)
    func didSelectAt(row: Int)
    func willDisplayCurrentPage(row: Int)
}

protocol CollectionViewModelProtocol { }

protocol CollectionViewProtocol {
    associatedtype ViewModel = CollectionViewModelProtocol
    func bindIn(viewModel: ViewModel)
}

extension CollectionSectionProtocol {
    func didSelectAt(row: Int) {}
    func willDisplayCurrentPage(row: Int) {}
}
