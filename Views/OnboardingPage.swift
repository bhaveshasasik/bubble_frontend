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
    @Binding var isOnboarding: Bool
    
    
    init(title: String,
             subtitle: String? = nil,
             description: String? = nil,
             imageName: String? = nil,
             showContinueButton: Bool = false,
             showSignUpButton: Bool = false,
             currentPage: Binding<Int>,
             isOnboarding: Binding<Bool> = .constant(true)) {
            self.title = title
            self.subtitle = subtitle
            self.description = description
            self.imageName = imageName
            self.showContinueButton = showContinueButton
            self.showSignUpButton = showSignUpButton
            self._currentPage = currentPage
            self._isOnboarding = isOnboarding
    }

    
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
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color(hex: "4A55A2"), textColor: Color.white))
                .padding(.bottom, 16)
            }
            
            if showSignUpButton {
                Button("Sign up") {
                    withAnimation {
                        isOnboarding = false
                    }
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color(hex: "4A55A2"), textColor: Color.white))
                .padding(.bottom, 16)

            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
    }
}
