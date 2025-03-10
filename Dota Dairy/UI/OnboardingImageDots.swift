//
//  OnboardingImageDots.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI

struct OnboardingImageDots: View {
    @Binding var count: Int
    @Binding var activeIndex: Int
    var body: some View {
        HStack {
            ForEach(0..<count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(index == activeIndex ? Color.ddBlue : Color.ddWhite.opacity(0.27))
                    .frame(width: 72, height: 6)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
}

#Preview {
    OnboardingImageDots(count: .constant(3), activeIndex: .constant(1))
}
