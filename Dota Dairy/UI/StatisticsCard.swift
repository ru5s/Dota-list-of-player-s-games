//
//  StatisticsCard.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct StatisticsCard: View {
    @Binding var title: String?
    @State var ifNotTitle: String
    @State var subtitle: String
    @State var color: Color = Color.ddWhite
    @State var canEdit: Bool = false
    @State var text: String = ""
    @State var keyBoard: UIKeyboardType = .decimalPad
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                if canEdit {
                    ZStack(alignment: .leading, content: {
                        TextField("", text: $text)
                            .foregroundColor(Color.clear)
                            .font(Font.system(size: 20, weight: .semibold))
                            .keyboardType(keyBoard)
                        Text(title ?? ifNotTitle)
                            .foregroundColor(color)
                            .font(Font.system(size: 20, weight: .semibold))
                            .allowsHitTesting(false)
                    })
                } else {
                    Text(title ?? ifNotTitle)
                        .foregroundColor(color)
                        .font(Font.system(size: 20, weight: .semibold))
                }
                Text(subtitle)
                    .font(Font.system(size: 13, weight: .regular))
            }
            Spacer()
        }
        .foregroundColor(Color.ddWhite)
        .padding(16)
        .background(Color.ddBlue)
        .cornerRadius(10)
        .onChange(of: text, perform: { value in
            title = value
            let userDefaults = UserDefaults()
            userDefaults.setValue(value, forKey: "ended tournaments")
            print(value)
        })
    }
}

//#Preview {
//    StatisticsCard(title: .constant(""), ifNotTitle: "0", subtitle: "Total wins")
//}
