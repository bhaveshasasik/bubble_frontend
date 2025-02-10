//
//  OnboardingView.swift
//  bubbleTests
//
//  Created by Bhavesh Sasikumar on 2/10/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboarding: Bool
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            SignInView(isOnboarding: $isOnboarding)
                .tag(0)
            
            OnboardingPage(
                title: "Welcome to\nThe Bubble!",
                subtitle: "The app\ndesigned for...",
                imageName: "bubble-logo",
                showContinueButton: true,
                currentPage: $currentPage
            )
                .tag(1)
            
            OnboardingPage(
                title: "Meeting New\nPeople Safely,",
                description: "Meeting new people doesn't have to feel risky. Group dating offers peace of mind with friends around to support and look out for you.",
                showContinueButton: true,
                currentPage: $currentPage
            )
                .tag(2)
            
            OnboardingPage(
                title: "Enjoyable\nDating,",
                description: "Dating should be enjoyable, not awkward. That's why we make every interaction group-centric. With your friends by your side, every outing turns into a shared adventure.",
                showContinueButton: true,
                currentPage: $currentPage
            )
                .tag(3)
            
            OnboardingPage(
                title: "& Unforgettable\nMemories.",
                description: "Unforgettable moments happen when people come together. The bubble creates experiences that are worth sharing.",
                showSignUpButton: true,
                currentPage: $currentPage,
                isOnboarding: $isOnboarding
            )
                .tag(4)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

