import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboarding: Bool
    @State private var currentPage = 0
    @State private var showRegistration = false  // Add this state variable
    
    var body: some View {
        if showRegistration {
            RegistrationFlow(isOnboarding: $isOnboarding)
        } else {
            TabView(selection: $currentPage) {
                SignInView(isOnboarding: $isOnboarding)
                    .tag(0)
                
                OnboardingPage(
                    title: "Welcome to\nThe Bubble!",
                    subtitle: "The app\ndesigned for...",
                    imageName: "bubble-logo",
                    showContinueButton: true,
                    currentPage: $currentPage,
                    isOnboarding: $isOnboarding
                )
                .tag(1)
                
                OnboardingPage(
                    title: "Meeting New\nPeople Safely,",
                    description: "Meeting new people doesn't have to feel risky. Group dating offers peace of mind with friends around to support and look out for you.",
                    showContinueButton: true,
                    currentPage: $currentPage,
                    isOnboarding: $isOnboarding
                )
                .tag(2)
                
                OnboardingPage(
                    title: "Enjoyable\nDating,",
                    description: "Dating should be enjoyable, not awkward. That's why we make every interaction group-centric. With your friends by your side, every outing turns into a shared adventure.",
                    showContinueButton: true,
                    currentPage: $currentPage,
                    isOnboarding: $isOnboarding
                )
                .tag(3)
                
                OnboardingPage(
                    title: "& Unforgettable\nMemories.",
                    description: "Unforgettable moments happen when people come together. The bubble creates experiences that are worth sharing.",
                    showSignUpButton: true,
                    currentPage: $currentPage,
                    isOnboarding: $isOnboarding,
                    onSignUp: { showRegistration = true } 
                )
                .tag(4)
            }
            #if os(iOS)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            #endif
        }
    }
}
