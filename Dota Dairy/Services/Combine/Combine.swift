//
//  Combine.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Combine

class CombineManager {
    static let shared = CombineManager()
    private init () {}
    var value = CurrentValueSubject<Bool, Never>(false)
}
