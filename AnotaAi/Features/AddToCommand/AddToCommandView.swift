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
    var total: String? { get }

    var fieldSideBySideViewModel: TextFieldSideBySideViewModelProtocol { get }
    var fieldViewViewModel: TextFieldViewModelProtocol { get }
    var counterViewModel: CounterViewModelProtocol { get }

    var onAddOneMoreFood: ((Bool, [FoodCardCellViewModelProtocol]?) -> Void)? { get set }
    var onChangeValues: (() -> Void)? { get set }
    
    func didAddToCommand()
}

class AddToCommandView: UIView {
    
    // MARK: - UI Components
    
    @IBOutlet private(set) weak var scrollView: UIScrollView!
    @IBOutlet private weak var previewImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var servesLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var textFieldSideBySide: TextFieldSideBySideView!
    @IBOutlet private weak var textFieldView: TextFieldView!
    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var collectionFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var counterView: CounterView!
    @IBOutlet private weak var addToCommandButton: Button!
    @IBOutlet private weak var totalLabel: UILabel!
    
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
        updateTotalLabel(viewModel.total ?? "")
        previewImageView.imageBy(url: viewModel.url)
        
        textFieldSideBySide.bindIn(viewModel: viewModel.fieldSideBySideViewModel)
        textFieldView.bindIn(viewModel: viewModel.fieldViewViewModel)
        counterView.bindIn(viewModel: viewModel.counterViewModel)
        
        self.viewModel?.onChangeValues = { [weak self] in
            self?.priceLabel.text = viewModel.price
            self?.updateTotalLabel(viewModel.total ?? "")
        }
        
        self.viewModel?.onAddOneMoreFood = { [weak self] addOneMore, viewModels in
            self?.addOrRemoveCollection(addOneMore, viewModels)
        }
    }
    
    private func addOrRemoveCollection(_ isAdd: Bool, _ viewModels: [FoodCardCellViewModelProtocol]?) {
        if isAdd {
            collectionDataSource.sections = [CollectionSection<FoodCardCell>(items: viewModels ?? [], delegate: self)]
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
        setupAddToCommandButton()
        setupCounterView()
        setupTotalLabel()
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
        textFieldSideBySide.first = "half_label".localize(.addToCommand)
        textFieldSideBySide.firstOptions = ["whole_option_label".localize(.addToCommand), "half_option_label".localize(.addToCommand)]
        
        textFieldSideBySide.second = "size_label".localize(.addToCommand)
        textFieldSideBySide.secondOptions = ["M", "G"]
    }
    
    private func setupTextFieldView() {
        textFieldView.title = "some_observe_hint_label".localize(.addToCommand)
        textFieldView.placeholder = "obs_exemple_hint_label".localize(.addToCommand)
    }
    
    private func setupCollectionView() {
        collectionFlowLayout.itemSize = CGSize(width: 160, height: 160)
        collectionDataSource.collectionView = collectionView
        collectionView?.isHidden = true
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func setupCounterView() {
        counterView.layer.cornerRadius = 8
    }
    
    private func setupAddToCommandButton() {
        addToCommandButton.style = .default
        addToCommandButton.title = "add_hint_label".localize(.default)
        addToCommandButton.addTarget(self, action: #selector(didTapAddToCommandButton), for: .touchUpInside)
    }
    
    private func setupTotalLabel() {
        totalLabel.textColor = .greenColor
    }
    
    // MARK: - Updates
    
    private func updateTotalLabel(_ total: String) {
        let text = "total_label".localize(.addToCommand, [total])
        let totalText = NSMutableAttributedString(string: text)
        totalText.setFont(font: .default(type: .bold, ofSize: 16), forText: text)
        totalText.setFont(font: .default(type: .bold, ofSize: 24), forText: total)
        totalLabel.attributedText = totalText
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddToCommandButton() {
        viewModel?.didAddToCommand()
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

extension AddToCommandView: CollectionSectionDelegate {
    
    func didSelect(items: [Any], row: Int) {
        guard let viewModels = items as? [FoodCardCellViewModelProtocol] else { return }
        viewModels.enumerated().forEach { $0.element.didSelect($0.offset == row) }
    }
}
