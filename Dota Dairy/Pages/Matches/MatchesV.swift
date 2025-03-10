//
//  MatchesV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct MatchesV: View {
    @ObservedObject var model: MatchesVM = MatchesVM()
    @State var victories: String = ""
    @State var defeats: String = ""
    @State var addMatch:Bool = false
    var body: some View {
        NavigationView(content: {
            ZStack(alignment: .bottomTrailing ,content: {
                NavigationLink(
                    destination: 
                        AddMatch(dismiss: $addMatch, updateData: {
                            model.getFetch()
                        })
                        .navigationTitle("Add match")
                        .navigationBarTitleDisplayMode(.inline)
                    ,
                    isActive: $addMatch,
                    label: {
                        EmptyView()
                    })
                VStack {
                    HStack {
                        Text("Statistics")
                            .font(Font.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.horizontal ,16)
                    HStack(spacing: 16) {
                        Group {
                            StatisticBaner(title: "Victories", textField: $victories)
                            StatisticBaner(title: "Defeats", textField: $defeats)
                        }
                        .padding(16)
                        .background(Color.active)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal ,16)
                    HStack {
                        Text("Matches")
                            .font(Font.system(size: 20, weight: .semibold))
                        Spacer()
                    }
                    .padding(.horizontal ,16)
                    if model.matches.isEmpty {
                        CustomEmptyView(title: "Empty", subtitle: "You don’t have any matches yet")
                            .frame(maxWidth: .infinity)
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack {
                                ForEach(Array(model.matches.enumerated()), id: \.element.id) { index, item in
                                    MatchesCell(match: item, updateData: {
                                        //update data from about match
                                        model.getFetch()
                                    })
                                        .addButtonActions(leadingButtons: [], trailingButton: [.delete]) { delete in
                                            withAnimation {
                                                CoreDataManager.shared.removeItemFromCoreData(id: item.id ?? UUID(), type: .match)
                                                model.getFetch()
                                            }
                                        }
                                        .padding(.horizontal ,16)
                                }
                            }
                            
                            Spacer()
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
                        addMatch.toggle()
                    })
                    .padding(.bottom, 10)
                    .padding(.trailing, 16)
            })
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("Matches")
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
    MatchesV()
}
