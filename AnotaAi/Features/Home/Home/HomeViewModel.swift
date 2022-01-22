//
//  HomeViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machdo on 14/07/20.
//  
//

import UIKit

protocol HomeProtocol: HomeViewModelProtocol {
    var onSelectHomeTab: ((HomeTab) -> Void)? { get set }
}

class HomeViewModel {
    
    // MARK: - Public properties
    
    let homeTabs: [HomeTab]

    var onUpdateTabBar: (() -> Void)?
    
    var onSelectHomeTab: ((HomeTab) -> Void)? {
        didSet {
            onSelectHomeTab?(selectedTab)
        }
    }
    
    var onSelectTabIndex: ((Int) -> Void)? {
        didSet {
            let index = homeTabs.firstIndex(of: selectedTab) ?? 0
            onSelectTabIndex?(index)
        }
    }
    
    // MARK: - Private properties
    
    private(set) lazy var tabs: [UITabBarItem] = {
        return homeTabs.enumerated().map {
            createTabBy(index: $0.offset, homeTab: $0.element)
        }
    }()
    
    private(set) var selectedTab: HomeTab = .menu {
        didSet {
            onSelectHomeTab?(selectedTab)
        }
    }

    // MARK: - Init
    
    init() {
        self.homeTabs = HomeTab.allCases
    }
    
    private func createTabBy(index: Int, homeTab: HomeTab) -> UITabBarItem {
        UITabBarItem(title: homeTab.title, image: homeTab.image, tag: index)
    }
}

extension HomeViewModel: HomeProtocol {

    func didSelecTabWith(tag: Int) {
        if tag < homeTabs.count {
            selectedTab = homeTabs[tag]
        }
    }
}
