//
//  AddMatch.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct AddMatch: View {
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
    @Binding var dismiss: Bool
    @State var updateData: () -> Void
    var body: some View {
        ZStack(content: {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack {
                        Group {
                            CustomTextField(textField: $gameName, placeholder: "Game name")
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextField(textField: $gameDate, placeholder: "Game date", keyboard: .numbersAndPunctuation)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextField(textField: $gameTime, placeholder: "Game time", keyboard: .numbersAndPunctuation)
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
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            Button {
                                positionDismis.toggle()
                            } label: {
                                HStack {
                                    if let position = position {
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
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextField(textField: $gameDuration, placeholder: "Game duration", keyboard: .numberPad)
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextField(textField: $playedHero, placeholder: "Played hero")
                            Divider()
                                .background(Color.ddWhite)
                                .padding(.horizontal, -16)
                            CustomTextField(textField: $yourKDA, placeholder: "Your KDA", keyboard: .numbersAndPunctuation)
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
                            
                        }
                        .padding(5)
                    }
                    .padding(16)
                    .background(Color.ddBlue)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                }
                
                ButtonRounded(title: "Add", completion: {
                    //touched add button
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    CoreDataManager.shared.saveMatch(
                        date: gameDate,
                        duration: gameDuration,
                        name: gameName, 
                        time: gameTime,
                        type: gameType?.rawValue ?? 0,
                        notes: [],
                        playedHero: playedHero,
                        position: position?.rawValue ?? 0,
                        win: winLose ?? false,
                        kda: yourKDA)
                    updateData()
                    dismiss.toggle()
                }, state: $addButton, backgroundColor: Color.active)
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
    AddMatch(dismiss: .constant(false), updateData: {})
}
