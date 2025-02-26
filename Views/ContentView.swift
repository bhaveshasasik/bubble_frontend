//
//  ContentView.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboarding = true
    
    
    var body: some View {
        if isOnboarding {
            OnboardingView(isOnboarding: $isOnboarding)
        } else {
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
