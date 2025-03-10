//
//  StatisticsVM.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation
import CoreData

struct HeroesMock: Hashable {
    let id: UUID = UUID()
    let name: String
    let game: Int
    let win: Int
    let position: GamerPosition
}

struct CalculateGamerHero: Equatable {
    var games: Int
    var wins: Int
    var defeats: Int
    var heroName: String
    var position: GamerPosition
}

class StatisticsVM: ObservableObject {
    @Published var heroes: [HeroesMock] = []
    @Published var countTournaments: String?
    @Published var hero: CalculateGamerHero?
    var tournaments: [Tournament] = []
    var fetchMatches: [Match] = []
   
    func fetchMatch() {
        let fetchRequest: NSFetchRequest<Match> = Match.fetchRequest()
        do {
            let fetchMatch = try CoreDataManager.shared.container.viewContext.fetch(fetchRequest)
            fetchMatches = fetchMatch
            heroes = []
            for item in fetchMatches {
                heroes.append(.init(
                    name: item.playedHero ?? "",
                    game: 1,
                    win: item.winOrLose ? 1 : 0,
                    position: GamerPosition(rawValue: item.position) ?? .mainRole))
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func fetchTournaments() {
        let fetchRequest: NSFetchRequest<Tournament> = Tournament.fetchRequest()
        do {
            let fetchTournament = try CoreDataManager.shared.container.viewContext.fetch(fetchRequest)
            tournaments = fetchTournament
            countTournaments = tournaments.count.description
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func allGamers() {
        var games: Int = 0
        var win: Int = 0
        var criteriaCounts: [GamerPosition: Int] = [:]
        for item in heroes {
            games += item.game
            win += item.win
        }
        for person in heroes {
            if let count = criteriaCounts[person.position] {
                criteriaCounts[person.position] = count + 1
            } else {
                criteriaCounts[person.position] = 1
            }
        }
        if let mostFrequentCriteria = criteriaCounts.max(by: { $0.value < $1.value }) {
            hero?.position = mostFrequentCriteria.key
        }
        print(hero?.position.description() ?? "all gamers no position")
        hero = .init(games: games, wins: win, defeats: games - win, heroName: "All heroes", position: .mainRole)
    }
    func choosedHero(name: String){
        var allGames: Int = 0
        var allWins: Int = 0
        var criteriaCounts: [GamerPosition: Int] = [:]
        let choosedHero = heroes.filter({$0.name == name})
        
        for item in choosedHero {
            allGames += item.game
            hero?.heroName = item.name
            allWins += item.win
            
            hero?.position = item.position
        }
        
        for person in choosedHero {
            if let count = criteriaCounts[person.position] {
                criteriaCounts[person.position] = count + 1
            } else {
                criteriaCounts[person.position] = 1
            }
        }
        if let mostFrequentCriteria = criteriaCounts.max(by: { $0.value < $1.value }) {
            hero?.position = mostFrequentCriteria.key
        }
        print(hero?.position.description() ?? "no position")
        hero?.games = allGames
        hero?.wins = allWins
        hero?.defeats = allGames - allWins
    }
    
    func mostPlayedHero() -> String {
        var criteriaCounts: [String: Int] = [:]
        for person in heroes {
            if let count = criteriaCounts[person.name] {
                criteriaCounts[person.name] = count + 1
            } else {
                criteriaCounts[person.name] = 1
            }
        }
        if let mostFrequentCriteria = criteriaCounts.max(by: { $0.value < $1.value }) {
            return mostFrequentCriteria.key
        } else {
            return "----"
        }
    }
    
    func mostPlayedPosition() -> String {
        var criteriaCounts: [String: Int] = [:]
        for person in heroes {
            if let count = criteriaCounts[person.position.description()] {
                criteriaCounts[person.position.description()] = count + 1
            } else {
                criteriaCounts[person.position.description()] = 1
            }
        }
        if let mostFrequentCriteria = criteriaCounts.max(by: { $0.value < $1.value }) {
            return mostFrequentCriteria.key
        } else {
            return "----"
        }
    }
}

extension StatisticsVM {
    func numberToWords(_ number: Int) -> String? {
        let numberWords = [
            0: "no", 1: "one", 2: "two", 3: "three", 4: "four",
            5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine",
            10: "ten", 11: "eleven", 12: "twelve", 13: "thirteen",
            14: "fourteen", 15: "fifteen", 16: "sixteen", 17: "seventeen",
            18: "eighteen", 19: "nineteen", 20: "twenty",
            30: "thirty", 40: "forty", 50: "fifty", 60: "sixty",
            70: "seventy", 80: "eighty", 90: "ninety"
        ]

        if let word = numberWords[number] {
            return word
        } else if number < 100 {
            let tens = number / 10 * 10
            let units = number % 10
            return "\(numberWords[tens]!) \(numberWords[units]!)"
        } else if number < 1000 {
            let hundreds = number / 100
            let remainder = number % 100
            if remainder == 0 {
                return "\(numberWords[hundreds]!) hundred"
            } else {
                return "\(numberWords[hundreds]!) hundred \(numberToWords(remainder)!)"
            }
        }
        return nil
    }
}
