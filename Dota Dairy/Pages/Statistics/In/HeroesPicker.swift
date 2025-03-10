//
//  HeroesPicker.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct HeroesPicker: View {
    @Binding var heroes: [HeroesMock]
    @State var choosedHero: (String) -> Void
    @Binding var dismiss: Bool
    @State var allName: [String] = []
    var body: some View {
        VStack(spacing: 0) {
            Text("Choose hero")
                .font(Font.system(size: 25, weight: .bold))
                .foregroundColor(Color.ddWhite)
                .padding(.vertical, 16)
            Divider()
            ForEach(Array(allName.enumerated()), id: \.element.self) {index, hero in
                    Button {
                        choosedHero(hero)
                        dismiss.toggle()
                    } label: {
                        Text(hero.capitalized)
                            .font(Font.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                Divider()
            }
            Button {
                choosedHero("All heroes")
                dismiss.toggle()
            } label: {
                Text("All heroes")
                    .foregroundColor(Color.ddWhite)
                    .font(Font.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.ddBlue)
            }
        }
        .frame(maxWidth: 300)
        .background(Color.ddBlue)
        .foregroundColor(Color.ddWhite)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0.0, y: 0.0)
        .offset(y: !dismiss ? 700 : 0)
        .animation(.easeInOut)
        .onAppear {
            allName = []
            unicName()
        }
    }
    
    private func unicName(){
        for item in heroes {
            if allName.isEmpty {
                allName.append(item.name)
            } else if allName.contains(where: {$0 == item.name}) {
                
            } else {
                allName.append(item.name)
            }
        }
    }
}

#Preview {
    HeroesPicker(heroes: .constant([
        .init(name: "name0", game: 12, win: 10, position: .carry),
        .init(name: "name1", game: 12, win: 10, position: .carry),
        .init(name: "name2", game: 12, win: 10, position: .carry),
    ]), choosedHero: {_ in}, dismiss: .constant(true))
}
