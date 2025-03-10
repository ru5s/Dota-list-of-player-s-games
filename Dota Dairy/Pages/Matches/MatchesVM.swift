//
//  MatchesVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation
import CoreData

class MatchesVM: ObservableObject {
    @Published var matches: [Match] = []
    
    func getFetch() {
        let fetchRequest: NSFetchRequest<Match> = Match.fetchRequest()
        do {
            let fetchMatch = try CoreDataManager.shared.container.viewContext.fetch(fetchRequest)
            matches = fetchMatch
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
