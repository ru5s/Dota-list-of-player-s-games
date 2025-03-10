//
//  StatisticBaner.swift
//  Dota Dairy
//
//  Created by Den on 09/03/24.
//

import SwiftUI

struct StatisticBaner: View {
    @State var title: String
    @Binding var textField: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text(title)
                .font(Font.system(size: 15, weight: .regular))
                .foregroundColor(Color.ddWhite)
            ZStack(alignment: .leadingFirstTextBaseline) {
                TextField("", text: $textField)
                    .foregroundColor(Color.ddWhite)
                    .keyboardType(.numberPad)
                Text(textField.isEmpty ? "0" : textField)
                    .foregroundColor(Color.ddWhite)
                    .allowsHitTesting(false)
            }
        })
        .onChange(of: textField, perform: { value in
            let userDefaults = UserDefaults()
            userDefaults.setValue(value, forKey: title)
        })
        .onAppear {
            let userDefaults = UserDefaults()
            textField = userDefaults.string(forKey: title) ?? ""
        }
    }
}

#Preview {
    StatisticBaner(title: "Victories", textField: .constant("0"))
}
