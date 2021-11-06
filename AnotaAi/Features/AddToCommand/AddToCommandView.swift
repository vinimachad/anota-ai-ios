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
    
    var onAddOneMoreFood: ((Bool) -> Void)? { get set }
    
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
    
    // MARK: - Private properties
    
    private(set) var viewModel: AddToCommandViewModelProtocol?
    
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
        
        self.viewModel?.onAddOneMoreFood = { [weak self] addOneMore in
            self?.addOrRemoveCollection(addOneMore)
        }
    }
    
    private func addOrRemoveCollection(_ isAdd: Bool) {
        if isAdd {
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
}

extension AddToCommandView {
    
    private func addCollection() {
        let collectionDataSource = CollectionViewDataSource()
        let collection = UICollectionView()
        collection.backgroundColor = .blackColor
        collectionDataSource.collectionView = collection
        
        let constraint = findConstraint(textFieldView.constraints, id: "TextViewTop")
        removeConstraint(constraint)
        
        collection.layout {
            $0.top.equal(textFieldSideBySide.bottomAnchor, constant: 10)
            $0.leading.equal(leadingAnchor, constant: 16)
            $0.trailing.equal(trailingAnchor, constant: -16)
            $0.bottom.equal(textFieldView.topAnchor, constant: 10)
            $0.height.equalTo(100)
        }
    }
    
    private func removeCollection() {
        
    }
    
    private func findConstraint(_ constraint: [NSLayoutConstraint], id: String) -> NSLayoutConstraint {
        constraint.filter { $0.identifier == id }.first ?? NSLayoutConstraint()
    }
}
