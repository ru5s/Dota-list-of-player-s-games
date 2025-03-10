//
//  MatchWinLose.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct MatchWinLose: View {
    @Binding var active: Bool
    @State var activeTextColor: Color
    @State var activeBackroundColor: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 28, height: 33, alignment: .center)
            .foregroundColor(active ? activeBackroundColor : Color.ddLBlue)
            .overlay(
                Text("W")
                    .foregroundColor(active ? activeTextColor : activeTextColor.opacity(0.5))
            )
    }
}

#Preview {
    MatchWinLose(active: .constant(false), activeTextColor: Color.ddDGreen, activeBackroundColor: Color.ddGreen)
}
