//
//  CustomPicker.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct GameTypePicker: View {
    @Binding var dismis: Bool
    @State private var title: String = "Game type"
    @State var confirm: (TypeGame) -> Void
    var body: some View {
        ZStack {
            if dismis {
                GeometryReader(content: { geometry in
                    VStack {
                        Text(title)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        .padding(.horizontal, 20)
                        
                        ForEach(TypeGame.allCases, id: \.id) {type in
                            Button(action: {
                                confirm(type)
                                dismis.toggle()
                            }, label: {
                                VStack {
                                    Divider()
                                    Text(type.description())
                                }
                            })
                        }
                    }
                    .padding(.vertical, 20)
                    .foregroundColor(Color.ddWhite)
                    .frame(maxWidth: geometry.size.width - 200)
                    .background(Color.ddBlue)
                    .cornerRadius(16)
                    .position(x: geometry.frame(in: .local).width / 2, y: geometry.frame(in: .local).height / 2)
                    .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0.0, y: 0.0)
                    
                })
                .onTapGesture {
                    dismis.toggle()
                }
            }
        }
        .background(Color.black.opacity(0.3))
    }
}

#Preview {
    GameTypePicker(dismis: .constant(true), confirm: {_ in})
}
