//
//  HomeView.swift
//  Muvver
//
//  Created by mano on 14/07/20.
//  Copyright © 2020 Jera. All rights reserved.
//

import UIKit

protocol HomeViewModelProtocol {
    var tabs: [UITabBarItem] { get }
    
    var onSelectTabIndex: ((Int) -> Void)? { get set }
    var onUpdateTabBar: (() -> Void)? { get set }

    func didSelecTabWith(tag: Int)
}

class HomeView: UIView {

    private var viewModel: HomeViewModelProtocol?

    // MARK: - UI Components
    
    @IBOutlet private weak var tabBar: UITabBar!

    // MARK: - View life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    // MARK: - Public methods
    
    func bindIn(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        self.setTabs(viewModel.tabs)

        self.viewModel?.onSelectTabIndex = { [weak self] index in
            self?.selectItemAt(index: index)
        }
        
        self.viewModel?.onUpdateTabBar = { [weak self] in
            guard let viewModel = self?.viewModel else { return }
            self?.setTabs(viewModel.tabs)
        }
    }

    func addViewAboveTabBar(_ view: UIView) {
        addSubview(view)
        sendSubviewToBack(view)

        view.layout {
            $0.top.equal(topAnchor)
            $0.bottom.equal(tabBar.topAnchor)
            $0.leading.equal(safeAreaLayoutGuide.leadingAnchor)
            $0.trailing.equal(safeAreaLayoutGuide.trailingAnchor)
        }
    }
}

extension HomeView {

    private func setup() {
        backgroundColor = .white
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.black
        tabBar.barTintColor = UIColor.white
    }

    private func selectItemAt(index: Int) {
        guard let items = tabBar.items else {
            fatalError("There aren't tabs add")
        }

        guard index >= 0 && index < items.count else {
            fatalError("Invalid selected index")
        }

        let selectedItem = items[index]
        tabBar.selectedItem = selectedItem
    }
    
    private func setTabs(_ tabs: [UITabBarItem]) {
        let saveSelectedItem = tabBar.selectedItem
        tabBar.setItems(tabs, animated: false)
        tabBar.selectedItem = saveSelectedItem
    }
}

extension HomeView: UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        viewModel?.didSelecTabWith(tag: item.tag)
    }
}
