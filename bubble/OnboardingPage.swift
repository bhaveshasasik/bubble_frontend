//
//  OnboardingPage.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/10/25.
//

import SwiftUI

struct OnboardingPage: View {
    let title: String
    var subtitle: String? = nil
    var description: String? = nil
    var imageName: String? = nil
    var showContinueButton = false
    var showSignUpButton = false
    @Binding var currentPage: Int
    @Binding var isOnboarding: Bool = .constant(true)  // Default value for pages that don't need it
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(title)
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.center)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
            
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let description = description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if showContinueButton {
                Button("Continue") {
                    withAnimation {
                        currentPage += 1
                    }
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color(hex: "4A55A2")))
            }
            
            if showSignUpButton {
                Button("Sign up") {
                    withAnimation {
                        isOnboarding = false
                    }
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color(hex: "4A55A2")))
            }
        }
        .padding(.bottom, 50)
    }
}
