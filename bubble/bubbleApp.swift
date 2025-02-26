//
//  bubbleApp.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/5/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import Foundation
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    Auth.auth().useEmulator(withHost: "localhost", port: 4000)
    return true
      

  func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}

@main
    struct BubbleApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        @StateObject private var authViewModel = AuthViewModel()
        
        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(authViewModel)
                    .onOpenURL{url in
                        GIDSignIn.sharedInstance.handle(url)
                    }
            }
        }
    }
}
