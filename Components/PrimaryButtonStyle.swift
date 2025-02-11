//
//  PrimaryButtonStyle.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/10/25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var textColor: Color
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(25)
            .padding(.horizontal)
    }
}
