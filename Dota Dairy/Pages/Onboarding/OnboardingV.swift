//
//  OnboardingV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct OnboardingV: View {
    @ObservedObject var model = OnboardingVM()
    @State var event: Bool
    @State var activeTab: Int = 0
    @State var openTabview: Bool = false
    @State var activeNextButton: Bool = true
    var body: some View {
        NavigationView(content: {
            ZStack {
            NavigationLink(
                destination: TabsV().navigationBarHidden(true),isActive: $openTabview,label: {EmptyView()})
                TabView(selection: $activeTab,
                        content:  {
                    ForEach(Array(model.onboardingStack.enumerated()), id: \.element) {index, data in
                        OnboardingCell(data: data, cellCount: model.onboardingStack.count, activeDot: $activeTab, state: $activeNextButton, completion: {
                            if activeTab < model.onboardingStack.count - 1 {
                                activeTab += 1
                            } else {
                                let defaults = UserDefaults.standard
                                defaults.set(true, forKey: "seen onboard")
                                DispatchQueue.main.async {
                                    openTabview.toggle()
                                }
                            }
                        }, event: event)
                        .tag(index)
                    }
                })
                .background(Image("background")
                    .resizable()
                    .scaledToFill())
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut)
            }
            .ignoresSafeArea()
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            model.mainAnswer(event)
        }
    }
}

#Preview {
    OnboardingV(event: false)
}
