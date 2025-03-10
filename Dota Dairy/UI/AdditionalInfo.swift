//
//  AdditionalInfo.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct AdditionalInfo: View {
    @Binding var editMode: Bool
    @Binding var text: String
    @State var completion: (String) -> Void = {_ in}
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading, content: {
                if text.isEmpty {
                    Text("Write some information...")
                        .foregroundColor(Color.ddWhite.opacity(0.5))
                }
                TextEditor(text: $text)
                    .backgroundTextEditor(Color.clear)
                    .foregroundColor(Color.ddWhite)
                    .font(Font.system(size: 17, weight: .semibold))
                    .disabled(!editMode)
            })
            Spacer()
            if editMode {
                Button(action: {
                    completion(text)
                }, label: {
                    Image(systemName: "trash")
                        .foregroundColor(Color.ddWhite.opacity(0.5))
                })
            }
        }
        .padding(16)
        .background(Color.active)
        .cornerRadius(10)
    }
}

#Preview {
    AdditionalInfo(editMode: .constant(false), text: .constant("12"))
}
