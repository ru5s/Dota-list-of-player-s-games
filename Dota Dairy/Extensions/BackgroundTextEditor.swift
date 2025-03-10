//
//  BackgroundTextEditor.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import Foundation
import SwiftUI

extension View {
    func backgroundTextEditor(_ content: Color) -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollContentBackground(.hidden)
                .background(content)
        } else {
            UITextView.appearance().backgroundColor = .clear
            return self.background(content)
        }
    }
}
