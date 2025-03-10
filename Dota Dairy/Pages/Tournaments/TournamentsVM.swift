//
//  TournamentsVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation
import CoreData

class TournamentsVM: ObservableObject {
    @Published var tournaments: [Tournament] = []
    
    func getFetch() {
        let fetchRequest: NSFetchRequest<Tournament> = Tournament.fetchRequest()
        do {
            let fetchTournament = try CoreDataManager.shared.container.viewContext.fetch(fetchRequest)
            tournaments = fetchTournament
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
