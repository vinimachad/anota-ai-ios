//
//  HomeTab.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machdo on 14/07/20.
//  
//

import UIKit

enum HomeTab: CaseIterable {
    case menu
    case requests
    case profile
    

    var title: String {
        switch self {
            case .menu: return "menu_hint_title".localize(.home)
            case .requests: return "request_hint_title".localize(.home)
            case .profile: return "profile_hint_title".localize(.home)
        }
    }

    var image: UIImage {
        switch self {
            case .menu: return UIImage()
            case .requests: return UIImage()
            case .profile: return UIImage()
        }
    }
}
