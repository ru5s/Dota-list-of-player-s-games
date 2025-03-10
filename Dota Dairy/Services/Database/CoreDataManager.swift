//
//  CoreDataManager.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentCloudKitContainer = {
        return NSPersistentCloudKitContainer(name: "Dota_Dairy")
    }()
    
    init(inMemory: Bool = false) {
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, err in
            if let err = err {
                fatalError(err.localizedDescription)
            }
        }
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access document directory")
        }
        let dbURL = documentDirectory.appendingPathComponent("Hockey_Dairy_Application.sqlite")
        print("Path to database: \(dbURL.path)")
    }
    
    func save() throws {
        let context = container.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
    func saveMatch(date: String, duration: String, name: String, time: String, type: Int16, notes: [Additional], playedHero: String, position: Int16, win: Bool, kda: String) {
        let item = Match(context: container.viewContext)
        item.id = UUID()
        item.gameDate = date
        item.gameDuration = duration
        item.gameName = name
        item.gameTime = time
        item.gameType = type
        item.playedHero = playedHero
        item.position = position
        item.winOrLose = win
        item.yourKDA = kda
        item.addDate = Date()
        
        var temp: [String] = []
        for note in notes {
            temp.append(note.text)
        }
        item.notes = temp
        
        try? save()
    }
    
    func saveTournament(date: Date, location: String, prizePool: String, tournamentDescription: String, tournamentName: String, notes: [Additional]) {
        let item = Tournament(context: container.viewContext)
        item.id = UUID()
        item.date = date
        item.location = location
        item.prizePool = prizePool
        item.tournamentDescription = tournamentDescription
        item.tournamentName = tournamentName
        
        var temp: [String] = []
        for note in notes {
            temp.append(note.text)
        }
        item.tournamentNotes = temp
        
        try? save()
    }
    
    func removeItemFromCoreData(id: UUID, type: EntityName) {
        switch type {
        case .match:
            if let findItem = searchMatch(forUUID: id) {
                let context = container.viewContext
                context.delete(findItem)
                try? save()
            }
        case .tournament:
            if let findItem = searchTournament(forUUID: id) {
                let context = container.viewContext
                context.delete(findItem)
                try? save()
            }
        } 
    }
    
    func removeAllFromEntity(entityName: EntityName) {
        print("erase data in \(entityName)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName.rawValue)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
}
//search items
extension CoreDataManager {
    
    func searchMatch (forUUID uuid: UUID) -> Match? {
        let fetchRequest: NSFetchRequest<Match> = Match.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func searchTournament (forUUID uuid: UUID) -> Tournament? {
        let fetchRequest: NSFetchRequest<Tournament> = Tournament.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }
    }
}

