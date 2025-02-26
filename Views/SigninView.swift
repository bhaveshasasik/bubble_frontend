//
//  SigninView.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/10/25.
//

import SwiftUI
import UIKit
import AuthenticationServices

struct SignInView: View {
    @Binding var isOnboarding: Bool
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingPathAuth = false
    @Environment(\.colorScheme) var colorScheme
    
    
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
                
                //sign in view with apple
                SignInWithAppleButton { request in
                    viewModel.handleSignInWithAppleRequest(request)
                } onCompletion: { result in
                    viewModel.handleSignInwithAppleCompletion(result)
                }
                .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
                .frame(width: 300, height: 50)
                .cornerRadius(8)
                
                //sign in view with google
                Button(action: {
                    Task {
                        await viewModel.signInWithGoogle()
                    }
                }) {
                    HStack {
                        Image("Google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 8)
                        
                        Text("Sign in with Google")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.black) // Ensure text is black for contrast
                            .padding(.trailing, 8)
                    }
                    .frame(width: 295, height: 45) // Adjust width to match design
                    .background(Color.white) // Make full button white
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Light gray border for definition
                    )
                }
                
                
                //sign in view for phone number
                Button(action: {
                    Task {
                        {}
                    }
                }) {
                    HStack {
                        Text("Sign in with Phone")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.black) // Ensure text is black for contrast
                            .padding(.trailing, 8)
                    }
                    .frame(width: 295, height: 45) // Adjust width to match design
                    .background(Color.orange) // Make full button white
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Light gray border for definition
                    )
                }
                
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
