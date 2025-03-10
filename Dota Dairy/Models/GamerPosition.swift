//
//  GamerPosition.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import Foundation

enum GamerPosition: Int16, CaseIterable, Identifiable {
    case mainRole
    case carry
    case midCore
    case offLaner
    case semiSupport
    
    var id: Self { self }
    
    func description() -> String {
        switch self {
        case .mainRole:
            return "Main Role"
        case .carry:
            return "Carry"
        case .midCore:
            return "Mid Core"
        case .offLaner:
            return "OffLaner"
        case .semiSupport:
            return "Semi-Support"
        }
    }
}
