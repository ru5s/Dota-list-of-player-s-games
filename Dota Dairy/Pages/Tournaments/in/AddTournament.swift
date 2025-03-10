//
//  AddTournament.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct AddTournament: View {
    @State var tournamentName: String = ""
    @State var location: String = ""
    @State var date: Date = Date()
    @State var choosedDate: Bool = false
    @State var pricePool: String = ""
    @State var description: String = ""
    @State var addButton: Bool = false
    @Binding var dismiss: Bool
    @State var updateData: () -> Void = {}
    var body: some View {
        VStack {
            VStack {
                Group {
                    CustomTextField(textField: $tournamentName, placeholder: "Tournament name")
                    Divider()
                        .background(Color.ddWhite)
                        .padding(.horizontal, -16)
                    CustomTextField(textField: $location, placeholder: "Location", keyboard: .default)
                    Divider()
                        .background(Color.ddWhite)
                        .padding(.horizontal, -16)
                    CustomDatePicker(currentDate: $date, editMode: .constant(true), choosedDate: $choosedDate)
                        .frame(height: 20)
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
                    CustomTextField(textField: $pricePool, placeholder: "Price pool", keyboard: .decimalPad, addDollarSign: true)
                    Divider()
                        .background(Color.ddWhite)
                        .padding(.horizontal, -16)
                    CustomTextField(textField: $description, placeholder: "Decription", keyboard: .default)
                        
                }
                .padding(5)
            }
            .padding(16)
            .background(Color.ddBlue)
            .cornerRadius(10)
            .padding(.bottom, 10)
            .padding(.top, 16)
            Spacer()
            ButtonRounded(title: "Add", completion: {
                //touched add button
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                CoreDataManager.shared.saveTournament(date: date, location: location, prizePool: pricePool, tournamentDescription: description, tournamentName: tournamentName, notes: [])
                updateData()
                dismiss.toggle()
            }, state: $addButton, backgroundColor: Color.active)
        }
        .padding(16)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Add tournament")
        .onChange(of: tournamentName, perform: { value in
            checkFields()
        })
        .onChange(of: location, perform: { value in
            checkFields()
        })
        .onChange(of: pricePool, perform: { value in
            checkFields()
        })
        .onChange(of: description, perform: { value in
            checkFields()
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private func checkFields() {
        if !tournamentName.isEmpty && !location.isEmpty && !pricePool.isEmpty && !description.isEmpty 
            && choosedDate
        {
            addButton = true
        } else {
            addButton = false
        }
    }
    
    private func fullDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

#Preview {
    AddTournament(dismiss: .constant(true))
}
