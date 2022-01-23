//
//  CommandCellViewModel.swift
//  AnotaAi
//
//  Created by Vinicius Galhardo Machado on 22/01/22.
//

import Foundation
import UIKit

enum Stats {
    case waiting
    case preparing
    case concluded
    
    var title: String {
        switch self {
        case .concluded: return "concluded".localize(.command)
        case .preparing: return "preparing".localize(.command)
        case .waiting: return "waiting".localize(.command)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .waiting: return UIColor.errorColor
        case .preparing: return UIColor.yellowColor
        case .concluded: return UIColor.greenColor
        }
    }
}

class CommandCellViewModel {
    
    // MARK: - Public properties
    
    var title: String?
    var subtitle: String?
    var status: Stats?
    
    // MARK: - Private properties
    
    // MARK: - Init
    
    init(title: String?, subtitle: String?, status: String?) {
        self.title = title
        self.subtitle = subtitle
        self.status = updateStatus(status: status)
    }
}

extension CommandCellViewModel: CommandCellViewModelProtocol {    
    
    private func updateStatus(status: String?) -> Stats {
        switch status {
        case "waiting": return .waiting
        case "preparing": return .preparing
        case "concluded": return .concluded
        default: return .waiting
        }
    }
}
