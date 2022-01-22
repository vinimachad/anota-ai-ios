//
//  MenuViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 30/10/21.
//

import Foundation

protocol MenuProtocol: MenuViewModelProtocol {
    var onFailureGetFoods: ((String) -> Void)? { get set }
    var onOpenAddToCommand: ((Food?, [Food?]) -> Void)? { get set }
    func getMenu()
}

class MenuViewModel {
    
    // MARK: - Public properties
    
    var onFailureGetFoods: ((String) -> Void)?
    var onChangeFoods: (([FoodCellViewModelProtocol]) -> Void)?
    var onOpenAddToCommand: ((Food?, [Food?]) -> Void)?
    
    // MARK: - Private properties
    
    private var foods: [Food?] = []
    private let menuUseCase: MenuUseCaseProtocol?
    private let session: AnotaAiSessionProtocol
    
    // MARK: - Init
    
    init(menuUseCase: MenuUseCaseProtocol, session: AnotaAiSessionProtocol = AnotaAiSession.shared) {
        self.menuUseCase = menuUseCase
        self.session = session
    }
    
    private func generateViewModels() -> [FoodCellViewModelProtocol] {
        foods.map {
            FoodCellViewModel(
                stringUrl: $0?.preview,
                name: $0?.name,
                description: $0?.description,
                serves: $0?.serves,
                pricing: $0?.price,
                onSelect: self.didOpenAddToCommand(_:)
            )
        }
    }
}

extension MenuViewModel: MenuProtocol {
    
    var name: String? {
        guard let firstName = session.user?.name?.split(separator: " ").first else { return "n/d" }
        return String(firstName)
    }
    
    // MARK: - Requests
    
    func getMenu() {
        menuUseCase?.execute(
            ids: ["foods", "salty", "pizzas", "sweet"],
            success: { [weak self] foods in
                self?.foods = foods
                guard let viewModels = self?.generateViewModels() else { return }
                self?.onChangeFoods?(viewModels)
            },
            failure: { [weak self] error in
                self?.onFailureGetFoods?(error)
            }
        )
    }
    
    // MARK: - Actions
    
    func didOpenAddToCommand(_ food: Food?) {
        onOpenAddToCommand?(food, foods)
    }
    
    func didSelect(viewModel: FoodCellViewModelProtocol, row: Int?) {
        guard let realViewModel = viewModel as? FoodCellViewModel else { return }
        realViewModel.didSelect(foods[row ?? 0])
    }
}
