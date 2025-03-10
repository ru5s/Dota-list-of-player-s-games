//
//  SplashVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation

class SplashVM: ObservableObject {
    @Published var progress: ProgressBarModel = .start
    @Published var onboarding: Bool = false
    @Published var tabView: Bool = false
    @Published var event: Bool?
    
    private var timer: Double = 0.0
    
    private func seenOnboard() {
        let defaults = UserDefaults.standard
//        defaults.setValue(false, forKey: "seen onboard")
        let bool = defaults.bool(forKey: "seen onboard")
        bool ? tabView.toggle() : onboarding.toggle()
    }
    func starTtimer() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { time in
            if self.timer <= 0.9 {
                self.timer += 0.1
                if self.timer == 0.3 {
                    self.progress = .firstQuarter
                }
                if self.timer == 0.5 {
                    self.progress = .half
                }
                if self.timer == 0.7 {
                    self.progress = .thirdQuarter
                }
            } else {
                self.progress = .full
                time.invalidate()
                self.seenOnboard()
            }
        }
    }
}
