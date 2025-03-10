//
//  MatchesCell.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct MatchesCell: View {
    @State var win: Bool = false
    @State var lose: Bool = false
    @State var date: Date = Date()
    @State var game: String = ""
    @State var typeGame: TypeGame = .normal
    @State var duration: String = ""
    @State var kda: String = ""
    @State var aboutMatch: Bool = false
    @State var match: Match?
    @State var updateData: () -> Void = {}
    var body: some View {
        HStack {
            NavigationLink(
                destination: 
                    AboutMatch(dismiss: $aboutMatch, match: match, updateData: {
                        updateData()
                    })
                    .navigationBarTitleDisplayMode(.inline)
                ,
                isActive: $aboutMatch,
                label: {
                    EmptyView()
                })
            MatchWinLose(active: $win, activeTextColor: Color.ddDGreen, activeBackroundColor: Color.ddGreen)
            VStack(alignment: .center) {
                Text(fullDate(date:date))
                    .font(Font.system(size: 11))
                Spacer()
                Text(game)
                    .font(Font.system(size: 20, weight: .semibold))
                Spacer()
                HStack(spacing: 8) {
                    Group {
                        Text(typeGame.description())
                        Text(duration + "min.")
                        Text(kda)
                    }
                    .font(Font.system(size: 11))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.ddLBlue)
                    .cornerRadius(4)
                }
            }
            .frame(maxWidth: .infinity)
            MatchWinLose(active: $lose, activeTextColor: Color.ddDRed, activeBackroundColor: Color.ddRed)
        }
        .padding(16)
        .frame(maxHeight: 103)
        .foregroundColor(Color.ddWhite)
        .background(Color.ddBlue)
        .cornerRadius(10)
        .onAppear {
            date = match?.addDate ?? Date()
            game = match?.gameName ?? ""
            typeGame = TypeGame(rawValue: match?.gameType ?? 0) ?? .normal
            duration = match?.gameDuration ?? ""
            kda = match?.yourKDA ?? ""
            win = match?.winOrLose ?? false
            lose = !win
        }
        .onTapGesture {
            aboutMatch.toggle()
        }
    }
    
    private func fullDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

#Preview {
    MatchesCell(win: true, game: "Game-01", typeGame: .normal, duration: "70", kda: "10/2/33", match: .init(context: CoreDataManager.shared.container.viewContext))
}
