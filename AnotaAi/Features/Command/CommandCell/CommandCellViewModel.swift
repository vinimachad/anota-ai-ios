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
    var value: String?
    var size: String?
    var nameClient: String?
    
    // MARK: - Init
    
    init(title: String?, subtitle: String?, status: String?, value: Double?, size: String?, clientName: String?) {
        self.title = title
        self.subtitle = updateSubtitle(subtitle)
        self.status = updateStatus(status: status)
        self.value = updateToCurrency(value)
        self.size = size
        self.nameClient = clientName
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
    
    private func updateToCurrency(_ val: Double?) -> String? {
        val?.localizedCurrency()
    }
    
    private func updateSubtitle(_ subtitle: String?) -> String? {
        guard let subtitle = subtitle, !subtitle.isEmpty else {
            return "Nenhuma observação"
        }
        return subtitle
    }
}
