//
//  OnboardingModel.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation

struct OnboardingModel: Hashable {
    let id: UUID = UUID()
    let picture: String
    let title: String
    let subtitle: String
}
