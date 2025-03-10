//
//  CustomTextField.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var textField: String
    @State var placeholder: String
    @State var keyboard: UIKeyboardType = .default
    @State var addDollarSign: Bool = false
    var body: some View {
        ZStack(alignment: .leadingFirstTextBaseline) {
            TextField("", text: $textField)
                .foregroundColor(Color.clear)
                .keyboardType(keyboard)
                .padding(.leading, textField.isEmpty ? 0 : (addDollarSign ? 10 : 0))
            Text(textField.isEmpty ? placeholder : (addDollarSign ? ("$" + textField) : textField))
                .foregroundColor(textField.isEmpty ? Color.ddLBlue : Color.ddWhite)
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    CustomTextField(textField: .constant(""), placeholder: "Enter text")
}
