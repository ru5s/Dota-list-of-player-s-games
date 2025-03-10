//
//  ButtonRounded.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct ButtonRounded: View {
    @State var title: String
    @State var completion: () -> Void = {}
    @Binding var state: Bool
    @State var backgroundColor: Color?
    
    var body: some View {
        Button {
            completion()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 62)
                .font(Font.system(size: 17, weight: .semibold))
                .foregroundColor(state ? Color.ddWhite : Color.ddWhite.opacity(0.5))
        }
        .background(backgroundColor ?? Color.ddBlue)
        .accentColor(state ? Color.ddWhite : Color.ddWhite.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .disabled(state ? false : true)
    }
}

#Preview {
    ButtonRounded(title: "next", state: .constant(true))
}
