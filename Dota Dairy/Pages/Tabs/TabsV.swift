//
//  TabsV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct TabsV: View {
    var body: some View {
        NavigationView(content: {
            ZStack {
                TabView {
                    MatchesV()
                        .tabItem {
                            Image(systemName: "gamecontroller.fill")
                        }
                        .tag(0)
                    TournamentsV()
                        .tabItem {
                            Image(systemName: "trophy.fill")
                        }
                        .tag(1)

                    StatisticsV()
                        .tabItem {
                            Image(systemName: "chart.xyaxis.line")
                        }
                        .tag(2)
                    SettingsV()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                        }
                        .tag(3)
                }
                .accentColor(Color.ddBlue)
            }
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    TabsV()
}
