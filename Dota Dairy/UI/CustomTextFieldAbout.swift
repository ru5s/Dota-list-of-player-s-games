//
//  CustomTextFieldAbout.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct CustomTextFieldAbout: View {
    @Binding var textField: String
    @State var placeholder: String
    @State var keyboard: UIKeyboardType = .default
    @State var addDollarSign: Bool = false
    @Binding var editMode: Bool
    var body: some View {
        HStack(spacing: 0){
            if editMode {
                HStack(spacing: 0, content: {
                    Text(placeholder)
                        .foregroundColor(Color.ddLBlue)
                        .allowsHitTesting(false)
                    if addDollarSign {
                        Text("$")
                            .foregroundColor(Color.ddWhite)
                            .allowsHitTesting(false)
                    }
                })
            } else {
                if addDollarSign {
                    Text("$")
                        .foregroundColor(Color.ddWhite)
                        .allowsHitTesting(false)
                }
            }
            TextField("", text: $textField)
                .foregroundColor(Color.ddWhite)
                .keyboardType(keyboard)
                .disabled(!editMode)
        }
    }
}

#Preview {
    CustomTextFieldAbout(textField: .constant("dfdfdf"), placeholder: "placeholder: ", editMode: .constant(true))
}
