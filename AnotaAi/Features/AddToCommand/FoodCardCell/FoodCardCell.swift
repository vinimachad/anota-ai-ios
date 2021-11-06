//
//  FoodCardCell.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 06/11/21.
//

import Foundation
import UIKit

protocol FoodCardCellViewModelProtocol: CollectionViewModelProtocol {
    var url: URL? { get }
    var name: String? { get }
    var description: String? { get }
    var price: String? { get }
    func didSelect(_ food: Food?)
}

class FoodCardCell: UICollectionViewCell, CollectionViewProtocol {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Private properties
    
    private var viewModel: FoodCardCellViewModelProtocol?
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: FoodCardCellViewModelProtocol) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        priceLabel.text = viewModel.price
        previewImageView.imageBy(url: viewModel.url)
    }
    
    
}

extension FoodCardCell {
    
    // MARK: - View setup
    
    private func setup() {
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupPriceLabel()
        backgroundColor = .white
        layer.cornerRadius = 8
    }
    
    private func setupPreviewImageView() {
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.layer.cornerRadius = 8
    }
    
    private func setupNameLabel() {
        nameLabel.font = .default(type: .regular, ofSize: 16)
        nameLabel.textColor = .blackColor
        nameLabel.numberOfLines = 1
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = .default(type: .regular, ofSize: 14)
        descriptionLabel.textColor = .grayColor
        descriptionLabel.numberOfLines = 2
    }
    
    private func setupPriceLabel() {
        priceLabel.font = .default(type: .regular, ofSize: 14)
        priceLabel.textColor = .greenColor
        priceLabel.numberOfLines = 1
    }
}
