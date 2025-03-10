//
//  TextFieldAboutToDescription.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct TextFieldAboutToDescription: View {
    @Binding var textField: String
    @State var placeholder: String
    @State var keyboard: UIKeyboardType = .default
    @Binding var editMode: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            if editMode {
                Text(placeholder)
                    .foregroundColor(Color.ddLBlue)
                    .allowsHitTesting(false)
            }
            TextEditor(text: $textField)
                .foregroundColor(Color.ddWhite)
                .keyboardType(keyboard)
                .disabled(!editMode)
                .backgroundTextEditor(Color.clear)
                .padding(.leading, -5)
        }
    }
}

#Preview {
    TextFieldAboutToDescription(textField: .constant(""), placeholder: "placeholder: ", editMode: .constant(true))
}
