//
//  SigninView.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/10/25.
//

import SwiftUI

struct SignInView: View {
    @Binding var isOnboarding: Bool
    
    var body: some View {
        ZStack {
            // Background Image
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(0.3)
                        .ignoresSafeArea(.all)
                )
            VStack(spacing: 16) {
                Spacer()
                
                Text("THE")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Bubble")
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Better Together.")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                Button("Sign in with Apple") {
                    // Handle Apple sign in
                    isOnboarding = false
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color.black, textColor: Color.black))

                Button("Sign in with Facebook") {
                    // Handle Facebook sign in
                    isOnboarding = false
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color(hex: "4A55A2"), textColor: Color.black))
                
                Button("Sign in with Phone Number") {
                    // Handle phone number sign in
                    isOnboarding = false
                }
                .buttonStyle(PrimaryButtonStyle(backgroundColor: Color(hex: "CD7F32"), textColor: Color.black))
                
                Text("By signing up to The Bubble, you agree to our Terms of Service, Learn how we process your data in our Privacy Policy and our Cookies Policy.")
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.bottom, 50)
        }
    }
}
