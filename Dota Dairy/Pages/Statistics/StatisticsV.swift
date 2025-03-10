//
//  StatisticsV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct StatisticsV: View {
    @ObservedObject var model: StatisticsVM = StatisticsVM()
    @State var listOfHero: Bool = false
    @State var wins: String?
    @State var defeats: String?
    @State var countTournaments: String?
    @State var mostHeroName: String?
    @State var mostHeroPosition: String?
    @State var allName: [String] = []
    @State var changedEndedTournaments: String = ""
    @State var pieSlice: PieSliceData = .init(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 100), color: Color.ddYellowGraphic)
    var body: some View {
        NavigationView(content: {
            ZStack {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Total games played -")
                                    .font(Font.system(size: 17, weight: .semibold))
                                    .foregroundColor(Color.ddWhite)
                                Text((model.numberToWords(allName.count)?.capitalized ?? "No") + (model.heroes.count <= 1 ? " hero" : " heroes"))
                                    .font(Font.system(size: 17, weight: .semibold))
                                    .foregroundColor(Color.active)
                                Spacer()
                            }
                            .padding(.bottom, 16)
                            ZStack(alignment: .center) {
                                RoundDiagramm(pieSliceData: pieSlice)
                                    .frame(width: 200, height: 200, alignment: .center)
                                    
                                VStack {
                                    Text("Games")
                                        .foregroundColor(Color.ddLBlue)
                                    Text(model.hero?.games.description ?? "--")
                                        .font(Font.system(size: 35, weight: .semibold))
                                }
                                HStack {
                                    Text(model.hero?.heroName ?? "-----")
                                        .font(Font.system(size: 17, weight: .semibold))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 4)
                                        .foregroundColor(Color.ddWhite)
                                }
                                .background(Color.ddLBlue.opacity(0.8))
                                .cornerRadiusWithBorder(radius: 20, borderLineWidth: 0.5, borderColor: Color.ddWhite, antialiased: true)
                                .padding(.leading, 170)
                                .padding(.bottom, 100)
                            }
                            Button {
                                listOfHero.toggle()
                            } label: {
                                HStack {
                                    Text("Choose hero")
                                }
                                .padding(.vertical, 12)
                                .frame(maxWidth: 450)
                                .background(Color.ddLBlue)
                                .cornerRadiusWithBorder(radius: 10, borderLineWidth: 0.5, borderColor: Color.ddWhite, antialiased: true)
                            }
                        }
                        .padding(16)
                        .foregroundColor(Color.ddWhite)
                        .background(Color.ddBlue)
                        .cornerRadius(10)
                        .padding(.top, 16)
                    }
                    Group {
                        HStack(spacing: 8) {
                            StatisticsCard(title: $wins, ifNotTitle: "0", subtitle: "Total wins", color: Color.ddGreen, canEdit: false)
                            StatisticsCard(title: $defeats, ifNotTitle: "0", subtitle: "Total defeats", color: Color.ddRed, canEdit: false)
                        }
                        HStack(spacing: 8) {
                            StatisticsCard(title: $model.countTournaments, ifNotTitle: "0", subtitle: "Added tournament", color: Color.ddWhite, canEdit: false)
                            StatisticsCard(title: $countTournaments, ifNotTitle: "0", subtitle: "Ended tournaments", color: Color.ddWhite, canEdit: true, text: changedEndedTournaments)
                        }
                        HStack(spacing: 8) {
                            StatisticsCard(title: $mostHeroName, ifNotTitle: "----", subtitle: "Most played hero", color: Color.ddWhite, canEdit: false, keyBoard: .default)
                            StatisticsCard(title: $mostHeroPosition, ifNotTitle: "----", subtitle: "Most played position", color: Color.ddWhite, canEdit: false, keyBoard: .default)
                        }
                    }
                    .padding(.top, 4)
                })
                HeroesPicker(heroes: $model.heroes, choosedHero: {name in
                    if name == "All heroes" {
                        model.allGamers()
                    } else {
                        model.choosedHero(name: name)
                    }
                }, dismiss: $listOfHero)
            }
            .padding(.horizontal, 16)
            .navigationTitle("Statistics")
        })
        .onAppear {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
            let userDefaults = UserDefaults()
            let endedTournaments = userDefaults.string(forKey: "ended tournaments")
            countTournaments = endedTournaments
            model.fetchTournaments()
            model.fetchMatch()
            model.allGamers()
            wins = String(model.hero?.wins ?? 0)
            defeats = String(model.hero?.defeats ?? 0)
            unicName()
            navigationSettings()
            mostHeroName = model.mostPlayedHero()
            mostHeroPosition = model.mostPlayedPosition()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: model.hero) { _ in
            wins = String(model.hero?.wins ?? 0)
            defeats = String(model.hero?.defeats ?? 0)
            if model.hero?.games != 0 {
                let newDegrees = ((model.hero?.wins ?? 0) * 360) / ((model.hero?.wins ?? 0) + (model.hero?.defeats ?? 0))
                pieSlice = .init(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double(newDegrees)), color: Color.ddYellowGraphic)
            } else {
                pieSlice = .init(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 0), color: Color.ddYellowGraphic)
            }
            
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    private func navigationSettings() {
        let coloredNavAppearance = UINavigationBarAppearance()
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor.active
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.ddWhite]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.ddWhite]
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    private func unicName(){
        for item in model.heroes {
            if allName.isEmpty {
                allName.append(item.name)
            } else if allName.contains(where: {$0 == item.name}) {
                
            } else {
                allName.append(item.name)
            }
        }
    }
}

#Preview {
    StatisticsV()
}
