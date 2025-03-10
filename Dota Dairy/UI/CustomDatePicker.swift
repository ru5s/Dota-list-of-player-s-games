//
//  DatePicker.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State private  var placeholder: String = "Date:"
    @Binding var editMode: Bool
    @Binding var choosedDate: Bool
    var body: some View {
        HStack {
            if !choosedDate {
                Text(placeholder)
                    .foregroundColor(Color.ddLBlue)
            }
            ZStack(alignment: .leading, content: {
                
                DatePicker("",
                           selection: $currentDate,
                           displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .blendMode(.color)
                    .opacity(0.1)
                    .disabled(!editMode)
                    .padding(.leading, -40)
                
                Text(choosedDate ? formattedDate : "")
                    .foregroundColor(Color.ddWhite)
                    .allowsHitTesting(false)
            })
            Spacer()
        }
        .onChange(of: currentDate, perform: { value in
            choosedDate = true
        })
    }
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, yyyy"
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}

#Preview {
    CustomDatePicker(currentDate: .constant(Date()), editMode: .constant(true), choosedDate: .constant(false))
}
