//
//  RootVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation

class RootVM: ObservableObject {
    @Published var event: Bool?
    
    private var timer: Double = 0.0
    
    func eventRequest(completion: @escaping (Bool) -> Void) {
        starTtimer { state in
            completion(state)
        }
    }
    
    private func starTtimer(timerEnd: @escaping (Bool) -> Void) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { time in
            if self.timer <= 0.9 {
                self.timer += 0.1
            } else {
                time.invalidate()
                timerEnd(true)
            }
        }
    }
}
