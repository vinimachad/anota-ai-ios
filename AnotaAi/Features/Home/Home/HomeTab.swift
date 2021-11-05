//
//  HomeTab.swift
//  Muvver
//
//  Created by mano on 14/07/20.
//  Copyright © 2020 Jera. All rights reserved.
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
