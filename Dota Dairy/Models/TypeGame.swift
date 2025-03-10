//
//  TypeGame.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import Foundation

enum TypeGame: Int16, CaseIterable, Identifiable {
    case ranked
    case normal
    
    var id: Self { self }
    
    func description() -> String {
        switch self {
        case .ranked:
            return "Ranked"
        case .normal:
            return "Normal"
        }
    }
}
