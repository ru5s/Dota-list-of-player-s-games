//
//  AboutMatch.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct AboutMatch: View {
    @State var addButton: Bool = false
    @State var gameName: String = ""
    @State var gameDate: String = ""
    @State var gameTime: String = ""
    @State var gameType: TypeGame?
    @State var gameTypeDismis: Bool = false
    @State var position: GamerPosition?
    @State var positionDismis: Bool = false
    @State var gameDuration: String = ""
    @State var playedHero: String = ""
    @State var yourKDA: String = ""
    @State var winLose: Bool?
    @State var editMode: Bool = false
    @Binding var dismiss: Bool
    @State var additionalInfo: [Additional] = []
    @State var match: Match?
    @State var updateData: () -> Void = {}
    var body: some View {
        ZStack(content: {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        Group {
                            CustomTextFieldAbout(textField: $gameName, placeholder: "Game name: ", editMode: $editMode)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextFieldAbout(textField: $gameDate, placeholder: "Game date: ", keyboard: .numbersAndPunctuation, editMode: $editMode)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextFieldAbout(textField: $gameTime, placeholder: "Game time: ", keyboard: .numbersAndPunctuation, editMode: $editMode)
                        }
                        .padding(5)
                    }
                    .padding(16)
                    .background(Color.ddBlue)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                    .padding(.top, 16)
                    VStack {
                        Group {
                            Button {
                                gameTypeDismis.toggle()
                            } label: {
                                HStack {
                                    if let gameType = gameType {
                                        if editMode {
                                            Text("Game type:")
                                                .foregroundColor(Color.ddLBlue)
                                        }
                                        Text(gameType.description())
                                            .foregroundColor(Color.ddWhite)
                                    } else {
                                        Text("Game type")
                                            .foregroundColor(Color.ddLBlue)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.up.chevron.down")
                                        .foregroundColor(Color.ddLBlue)
                                }
                            }
                            .disabled(editMode ? false : true)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            Button {
                                positionDismis.toggle()
                            } label: {
                                HStack {
                                    if let position = position {
                                        if editMode {
                                            Text("Position:")
                                                .foregroundColor(Color.ddLBlue)
                                        }
                                        Text(position.description())
                                            .foregroundColor(Color.ddWhite)
                                    } else {
                                        Text("Position")
                                            .foregroundColor(Color.ddLBlue)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.up.chevron.down")
                                        .foregroundColor(Color.ddLBlue)
                                }
                            }
                            .disabled(editMode ? false : true)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextFieldAbout(textField: $gameDuration, placeholder: "Game duration: ", keyboard: .numberPad, editMode: $editMode)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextFieldAbout(textField: $playedHero, placeholder: "Played hero: ", editMode: $editMode)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextFieldAbout(textField: $yourKDA, placeholder: "Your KDA: ", keyboard: .numbersAndPunctuation, editMode: $editMode)
                        }
                        .padding(5)
                    }
                    .padding(16)
                    .background(Color.ddBlue)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                    
                    VStack {
                        Group {
                            
                            Button {
                                winLose = true
                            } label: {
                                HStack {
                                    Text("Win")
                                        .foregroundColor((winLose ?? false) ? Color.ddWhite : Color.ddLBlue)
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(Color.ddLBlue)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 3)
                                                .scaleEffect(0.8)
                                                .foregroundColor((winLose ?? false) ? Color.ddWhite : Color.ddBlue)
                                        )
                                    
                                }
                            }
                            .disabled(editMode ? false : true)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            Button {
                                winLose = false
                            } label: {
                                HStack {
                                    Text("Lose")
                                        .foregroundColor((winLose ?? true) ? Color.ddLBlue : Color.ddWhite)
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(Color.ddLBlue)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 3)
                                                .scaleEffect(0.8)
                                                .foregroundColor((winLose ?? true) ? Color.ddBlue : Color.ddWhite)
                                        )
                                    
                                }
                            }
                            .disabled(editMode ? false : true)
                        }
                        .padding(5)
                    }
                    .padding(16)
                    .background(Color.ddBlue)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                }
                
                HStack {
                    Text("Notes")
                        .font(Font.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.active)
                    Spacer()
                    if editMode {
                        Button {
                            let newItem: Additional = .init(text: "")
                            additionalInfo.append(newItem)
                        } label: {
                            Image(systemName: "plus.app")
                                .foregroundColor(Color.active)
                                .scaleEffect(1.3)
                        }
                    }
                }
                
                VStack(content: {
                    if additionalInfo.isEmpty {
                        Text("There are no saved notes.\n Click edit to add a note.")
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                    }
                    ForEach($additionalInfo, id: \.id) {text in
                        AdditionalInfo(editMode: $editMode, text: text.text, completion: { newText in
                            additionalInfo.removeAll(where: {$0.text == newText})
                        })
                    }
                    .frame(minHeight: 70)
                })
                .padding(.bottom, 16)
                
                if editMode {
                    ButtonRounded(title: "Save", completion: {
                        //touched save button
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                        DispatchQueue.main.async {
                            match?.gameName = gameName
                            match?.gameDate = gameDate
                            match?.gameTime = gameTime
                            match?.gameType = gameType?.rawValue ?? 0
                            match?.position = position?.rawValue ?? 0
                            match?.gameDuration = gameDuration
                            match?.playedHero = playedHero
                            match?.yourKDA = yourKDA
                            match?.addDate = Date()
                            match?.winOrLose = winLose ?? false
                            match?.notes = []
                            match?.notes?.append(contentsOf: additionalInfo.map({$0.text}))
                            try? CoreDataManager.shared.save()
                            editMode = false
                            updateData()
                        }
                    }, state: $addButton, backgroundColor: Color.active)
                    .padding(.bottom, 16)
                }
            }
            .padding(.horizontal ,16)
            GameTypePicker(dismis: $gameTypeDismis, confirm: {type in
                gameType = type
            })
            PositionTypePicker(dismis: $positionDismis, confirm: {type in
                position = type
            })
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .foregroundColor(Color.ddWhite)
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        editMode = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.ddLBlue)
                    }
                    .disabled(!editMode ? false : true)
                    Button {
                        DispatchQueue.main.async {
                            CoreDataManager.shared.removeItemFromCoreData(id: match?.id ?? UUID(), type: .match)
                            updateData()
                            dismiss.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundColor(Color.red)
                    }
                    
                }
            }
        }
        .onChange(of: gameName, perform: {_ in
            checkFields()
        })
        .onChange(of: gameDate, perform: {_ in
            checkFields()
        })
        .onChange(of: gameTime, perform: {_ in
            checkFields()
        })
        .onChange(of: gameDuration, perform: {_ in
            checkFields()
        })
        .onChange(of: playedHero, perform: {_ in
            checkFields()
        })
        .onChange(of: yourKDA, perform: {_ in
            checkFields()
        })
        .onChange(of: winLose, perform: {_ in
            checkFields()
        })
        .onChange(of: gameType, perform: {_ in
            checkFields()
        })
        .onChange(of: position, perform: {_ in
            checkFields()
        })
        .onAppear {
            gameName = match?.gameName ?? ""
            gameDate = match?.gameDate ?? ""
            gameTime = match?.gameTime ?? ""
            gameType = TypeGame(rawValue: match?.gameType ?? 0)
            position = GamerPosition(rawValue: match?.position ?? 0)
            gameDuration = match?.gameDuration ?? ""
            playedHero = match?.playedHero ?? ""
            yourKDA = match?.yourKDA ?? ""
            winLose = match?.winOrLose
            additionalInfo.removeAll()
            for item in match?.notes ?? [] {
                print(item)
                additionalInfo.append(.init(text: item))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func checkFields() {
        if (winLose != nil) && (gameType != nil) && (position != nil) && !gameName.isEmpty && !gameDate.isEmpty && !gameTime.isEmpty && !gameDuration.isEmpty && !playedHero.isEmpty && !yourKDA.isEmpty
        {
            addButton = true
        } else {
            addButton = false
        }
    }
}

#Preview {
    AboutMatch(dismiss: .constant(false), match: .init(context: CoreDataManager.shared.container.viewContext))
}
