//
//  SplashV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct SplashV: View {
    @ObservedObject var model: SplashVM = SplashVM()
    @State var event: Bool
    var body: some View {
        NavigationView(content: {
            VStack {
                NavigationLink(destination: OnboardingV(event: event).navigationBarHidden(true), isActive: $model.onboarding) {EmptyView()}
                NavigationLink(destination: TabsV().navigationBarHidden(true), isActive: $model.tabView) {EmptyView()}
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230)
                Spacer()
                ProgressView(value: model.progress.rawValue, total: 1.0)
                    .accentColor(Color.ddBlue)
                    .cornerRadius(3.0)
                    .scaleEffect(y: 2.0)
                    .padding(.horizontal, 100)
                    .padding(.bottom, 120)
            }
            .background(Image("background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            model.event = event
            model.starTtimer()
        }
    }
}

#Preview {
    SplashV(event: false)
}
