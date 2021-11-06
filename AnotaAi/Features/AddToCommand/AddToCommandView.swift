//
//  AddToCommandView.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 05/11/21.
//

import Foundation

import UIKit

protocol AddToCommandViewModelProtocol {
    var url: URL? { get }
    var name: String? { get }
    var description: String? { get }
    var serves: Int? { get }
    var price: String? { get }
    
    var onAddOneMoreFood: ((Bool, [FoodCardCellViewModelProtocol]?) -> Void)? { get set }
    
    var fieldSideBySideViewModel: TextFieldSideBySideViewModelProtocol { get }
    var fieldViewViewModel: TextFieldViewModelProtocol { get }
}

class AddToCommandView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var servesLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var textFieldSideBySide: TextFieldSideBySideView!
    @IBOutlet private weak var textFieldView: TextFieldView!
    @IBOutlet private var collectionView: UICollectionView?
    @IBOutlet private weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Private properties
    
    private(set) var viewModel: AddToCommandViewModelProtocol?
    private var collectionDataSource = CollectionViewDataSource()
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Bind
    
    func bindIn(viewModel: AddToCommandViewModelProtocol) {
        self.viewModel = viewModel
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        servesLabel.text = "serves_label".localize(.restaurantMenu, [String(viewModel.serves ?? 0)])
        priceLabel.text = viewModel.price
        previewImageView.imageBy(url: viewModel.url)
        
        textFieldSideBySide.bindIn(viewModel: viewModel.fieldSideBySideViewModel)
        textFieldView.bindIn(viewModel: viewModel.fieldViewViewModel)
        
        self.viewModel?.onAddOneMoreFood = { [weak self] addOneMore, viewModels in
            self?.addOrRemoveCollection(addOneMore, viewModels)
        }
    }
    
    private func addOrRemoveCollection(_ isAdd: Bool, _ viewModels: [FoodCardCellViewModelProtocol]?) {
        if isAdd {
            collectionDataSource.sections = [CollectionSection<FoodCardCell>(items: viewModels ?? [])]
            addCollection()
            return
        }
        removeCollection()
    }
}

// MARK: - View setup

extension AddToCommandView {
    private func setup() {
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupServesLabel()
        setupPriceLabel()
        setupTextFieldSideBySide()
        setupTextFieldView()
        setupCollectionView()
    }
    
    private func setupPreviewImageView() {
        previewImageView.contentMode = .scaleAspectFill
    }
    
    private func setupNameLabel() {
        nameLabel.font = .default(type: .bold, ofSize: 20)
        nameLabel.textColor = .blackColor
        nameLabel.numberOfLines = 0
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = .default(type: .regular, ofSize: 18)
        descriptionLabel.textColor = .grayColor
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupServesLabel() {
        servesLabel.font = .default(type: .bold, ofSize: 16)
        servesLabel.textColor = .blackColor
        servesLabel.numberOfLines = 1
    }
    
    private func setupPriceLabel() {
        priceLabel.font = .default(type: .bold, ofSize: 16)
        priceLabel.textColor = .greenColor
        priceLabel.numberOfLines = 1
    }
    
    private func setupTextFieldSideBySide() {
        textFieldSideBySide.first = "Pela metade?"
        textFieldSideBySide.firstOptions = ["Metade", "Inteira"]
        
        textFieldSideBySide.second = "Tamanho"
        textFieldSideBySide.secondOptions = ["G", "M"]
    }
    
    private func setupTextFieldView() {
        textFieldView.title = "Alguma observação?"
        textFieldView.placeholder = "Ex: Tirar azeitonas e cebolas..."
    }
    
    private func setupCollectionView() {
        collectionFlowLayout.itemSize = CGSize(width: 160, height: 160)
        collectionDataSource.collectionView = collectionView
        collectionView?.isHidden = true
    }
}

extension AddToCommandView {
    
    private func addCollection() {
        collectionView?.isHidden = false
    }
    
    private func removeCollection() {
        collectionView?.isHidden = true
    }
}
