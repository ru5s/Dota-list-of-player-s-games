//
//  AboutTournament.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct AboutTournament: View {
    @State var tournamentName: String = ""
    @State var location: String = ""
    @State var date: Date = Date()
    @State var pricePool: String = ""
    @State var description: String = ""
    @State var addButton: Bool = false
    @State var editMode: Bool = false
    @Binding var dismiss: Bool
    @State var additionalInfo: [Additional] = []
    @State var updateData: () -> Void = {}
    @State var tournament: Tournament?
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                VStack {
                    Group {
                        CustomTextFieldAbout(textField: $tournamentName, placeholder: "Tournament name: ", editMode: $editMode)
                        Divider()
                            .background(Color.ddWhite)
                            .padding(.horizontal, -16)
                        CustomTextFieldAbout(textField: $location, placeholder: "Location: ", keyboard: .default, editMode: $editMode)
                        Divider()
                            .background(Color.ddWhite)
                            .padding(.horizontal, -16)
                        CustomDatePickerAbout(currentDate: $date, editMode: $editMode)
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
                        CustomTextFieldAbout(textField: $pricePool, placeholder: "Price pool: ", keyboard: .decimalPad, addDollarSign: true, editMode: $editMode)
                        Divider()
                            .background(Color.ddWhite)
                            .padding(.horizontal, -16)
                        TextFieldAboutToDescription(textField: $description, placeholder: "Decription: ", keyboard: .default, editMode: $editMode)
                            .padding(-5)
                    }
                    .padding(5)
                }
                .padding(16)
                .background(Color.ddBlue)
                .cornerRadius(10)
                .padding(.bottom, 10)
                .padding(.top, 16)
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
                        //touched add button
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        DispatchQueue.main.async {
                            tournament?.tournamentDescription = description
                            tournament?.prizePool = pricePool
                            tournament?.date = date
                            tournament?.location = location
                            tournament?.tournamentName = tournamentName
                            tournament?.tournamentNotes = []
                            tournament?.tournamentNotes?.append(contentsOf: additionalInfo.map({$0.text}))
                            try? CoreDataManager.shared.save()
                            editMode = false
                            updateData()
                        }
                    }, state: $addButton, backgroundColor: Color.active)
                    .padding(.bottom, 16)
                }
            }
        })
        .padding(.horizontal ,16)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Add tournament")
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
                            CoreDataManager.shared.removeItemFromCoreData(id: tournament?.id ?? UUID(), type: .tournament)
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
        .onAppear {
            tournamentName = tournament?.tournamentName ?? ""
            location = tournament?.location ?? ""
            date = tournament?.date ?? Date()
            pricePool = tournament?.prizePool ?? ""
            description = tournament?.tournamentDescription ?? ""
            
            additionalInfo.removeAll()
            for item in tournament?.tournamentNotes ?? [] {
                print(item)
                additionalInfo.append(.init(text: item))
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    private func checkFields() {
        if !tournamentName.isEmpty && !location.isEmpty && !pricePool.isEmpty && !description.isEmpty
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
    AboutTournament(dismiss: .constant(false))
}
