//
//  OnboardingCell.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct OnboardingCell: View {
    @State var data: OnboardingModel
    @State var cellCount: Int
    @Binding var activeDot: Int
    @Binding var state: Bool
    @State var completion: () -> Void = {}
    @State var backgroundImage: String = "onboarding background"
    @State var event: Bool
    var body: some View {
        VStack {
            OnboardingImageDots(count: $cellCount, activeIndex: $activeDot)
            Text(data.title)
                .foregroundColor(Color.ddWhite)
                .font(Font.system(size: 28, weight: .bold))
                .padding(.bottom, 10)
            Text(data.subtitle)
                .foregroundColor(Color.ddWhite.opacity(0.7))
                .font(Font.system(size: 17, weight: .regular))
            Spacer()
            ZStack(alignment: .bottom) {
                Image(data.picture)
                    .resizable()
                    .scaledToFit()
                Image("bottom")
                    .resizable()
                    .scaledToFit()
                ButtonRounded(title: "Next", completion:  {
                    completion()
                }, state: $state)
                .padding(.bottom, 40)
                .padding(.horizontal, 16)
            }
        }
        .accentColor(Color.ddWhite)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    OnboardingCell(data: .init(picture: "onboarding 1", title: "Manage your team!", subtitle: "Be your own trainer!"), cellCount: 3, activeDot: .constant(1), state: .constant(true), event: false)
}
