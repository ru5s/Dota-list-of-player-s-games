//
//  TournamentsV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct TournamentsV: View {
    @ObservedObject var model: TournamentsVM = TournamentsVM()
    @State var addTournament: Bool = false
    var body: some View {
        NavigationView(content: {
            ZStack(alignment: .bottomTrailing) {
                NavigationLink(
                    destination: AddTournament(dismiss: $addTournament, updateData: {
                        // touched add button
                        model.getFetch()
                    }),
                    isActive: $addTournament,
                    label: {})
                VStack {
                    if model.tournaments.isEmpty {
                        CustomEmptyView(title: "Empty", subtitle: "You don’t have any added tournaments")
                            .frame(maxWidth: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(model.tournaments, id: \.id) { item in
                                    TournamentCell(tournament: item, updateData: {
                                        model.getFetch()
                                    })
                                        .addButtonActions(leadingButtons: [], trailingButton: [.delete]) { delete in
                                            CoreDataManager.shared.removeItemFromCoreData(id: item.id ?? UUID(), type: .tournament)
                                            model.getFetch()
                                        }
                                        .padding(.horizontal ,16)
                                }
                            }
                            .padding(.top, 16)
                        }
                    }
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(Color.active)
                    .overlay (
                        ZStack(content: {
                            RoundedRectangle(cornerRadius: 7)
                                .foregroundColor(Color.ddBlue)
                                .scaleEffect(0.8)
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .padding(9)
                                .foregroundColor(Color.ddWhite)
                        })
                    )
                    .onTapGesture(perform: {
                        addTournament.toggle()
                    })
                    .padding(.bottom, 10)
                    .padding(.trailing, 16)
            }
            .navigationTitle("Tournaments")
        })
        .onAppear {
            model.getFetch()
            navigationSettings()
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
}

#Preview {
    TournamentsV()
}
