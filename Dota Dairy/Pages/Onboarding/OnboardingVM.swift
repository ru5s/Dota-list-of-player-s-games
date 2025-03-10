//
//  OnboardingVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation

class OnboardingVM: ObservableObject {
    @Published var onboardingStack: [OnboardingModel] = []
    private let onboarding: [OnboardingModel] = [
        .init(picture: "onboarding 1", title: "Manage your team!", subtitle: "Be your own trainer!"),
        .init(picture: "onboarding 2", title: "Explore your own inventory", subtitle: "Awesome function"),
        .init(picture: "onboarding 3", title: "Be in focus with games", subtitle: "Fill out the game calendar!")
    ]
    func mainAnswer(_ event: Bool) {
        onboardingStack = onboarding
    }
}
