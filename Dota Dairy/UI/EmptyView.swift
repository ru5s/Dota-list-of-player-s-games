//
//  EmptyView.swift
//  Dota Dairy
//
//  Created by Den on 10/03/24.
//

import SwiftUI

struct CustomEmptyView: View {
    @State var title: String
    @State var subtitle: String
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .foregroundColor(Color.active)
                .font(Font.system(size: 28, weight: .bold))
            .padding(.bottom, 5)
        
            Text(subtitle)
                .foregroundColor(Color.active)
                .font(Font.system(size: 18, weight: .regular))
            Spacer()
        }
    }
}

#Preview {
    CustomEmptyView(title: "Title", subtitle: "Subtitle")
}
