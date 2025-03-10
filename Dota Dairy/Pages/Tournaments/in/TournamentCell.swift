//
//  TournamentCell.swift
//  Dota Dairy
//
//  Created by Den on 11/03/24.
//

import SwiftUI

struct TournamentCell: View {
    @State var date: Date = Date()
    @State var tournamentName: String = ""
    @State var description: String = ""
    @State var aboutTournament: Bool = false
    @State var tournament: Tournament?
    @State var updateData: () -> Void = {}
    var body: some View {
        HStack {
            NavigationLink(destination: AboutTournament(dismiss: $aboutTournament, updateData: {
                updateData()
            }, tournament: tournament), isActive: $aboutTournament, label: {})
            VStack(alignment: .leading) {
                Text(fullDate(date: date))
                    .foregroundColor(Color.ddWhite.opacity(0.5))
                    .font(Font.system(size: 11))
                Text(tournamentName)
                    .foregroundColor(Color.ddWhite)
                    .font(Font.system(size: 17, weight: .semibold))
                    .padding(.vertical, 3)
                Text(description)
                    .foregroundColor(Color.ddWhite.opacity(0.7))
                    .font(Font.system(size: 15))
                    .lineLimit(1)
                    .padding(.trailing, 34)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(16)
        .frame(maxHeight: 103)
        .foregroundColor(Color.ddWhite)
        .background(Color.ddBlue)
        .cornerRadius(10)
        .onTapGesture {
            aboutTournament.toggle()
        }
        .onAppear {
            date = tournament?.date ?? Date()
            tournamentName = tournament?.tournamentName ?? ""
            description = tournament?.tournamentDescription ?? ""
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
    TournamentCell(date: Date(), tournamentName: "", description: "")
}
