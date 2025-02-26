//
//  AuthViewModel.swift
//  bubble
//
//  Created by Bhavesh Sasikumar on 2/22/25.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseCore
import SwiftUI
import AuthenticationServices
import CryptoKit
import GoogleSignIn
import GoogleSignInSwift

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationError: Error {
    case tokenError(message: String)
}

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isValid: Bool = false
    @Published var authenticatedState: AuthenticationState = .unauthenticated
    @Published var displayName: String?
    
    private var verificationId: String?
    private var currentNonce: String?
    
    init() {
        setupFirebaseAuthStateListener()
    }
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    private func setupFirebaseAuthStateListener() {
            authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUser = user
                self?.authenticatedState = user != nil ? .authenticated : .unauthenticated
                self?.displayName = user?.displayName ?? user?.email ?? ""
            }
        }
    }
    
    // MARK - Apple Sign in
    func handleSignInWithAppleRequest(_ request:ASAuthorizationAppleIDRequest){
        request.requestedScopes = [.fullName, .email]
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
    }
    
    
    func handleSignInwithAppleCompletion(_ result: Result<ASAuthorization, Error>){
        
        //showing loading screen until login completes in firebase
        isLoading = true
        
        if case .failure(let failure) = result{
            errorMessage = failure.localizedDescription
            isLoading = false
        }
        else if case .success(let authorization) = result {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
              guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
              }
              guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
              }
              guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
              }
              // Initialize a Firebase credential, including the user's full name.
              let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                                rawNonce: nonce,
                                                                fullName: appleIDCredential.fullName)
              // Sign in with Firebase.
              Task{
                  do{
                      let result = try await Auth.auth().signIn(with: credential)
                      await updateDisplayName(for: result.user, with: appleIDCredential)
                  }
                  catch{
                      print("Error Authenticating:  \(error.localizedDescription)")
                  }
              }
            }
        }
    }
    
    //MARK - Google Sign in
    func signInWithGoogle() async -> Bool{
        guard let clientID = FirebaseApp.app()?.options.clientID else{
            fatalError("No client ID found in Firebase configuration")
        }
        //Google sign in object created
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else{
            print("There is no root view controller")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else{
                throw AuthenticationError.tokenError(message: "ID token missing")
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
        }
        catch{
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
            return false
        }
        return false
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
        }
        catch{
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    
    //helper functions
    func updateDisplayName(for user: User, with appleIDCredential: ASAuthorizationAppleIDCredential, force: Bool = false) async{
        if let currentDisplayName = Auth.auth().currentUser?.displayName, !currentDisplayName.isEmpty{
            //current user already has display name
        }else{
            let changeRequest = user.createProfileChangeRequest()
            
            if let fullname = appleIDCredential.fullName{
                let formatter = PersonNameComponentsFormatter()
                changeRequest.displayName = formatter.string(from: fullname)
            }
            
            do{
                try await changeRequest.commitChanges()
                self.displayName = Auth.auth().currentUser?.displayName ?? ""
            }
            catch{
                print("Unable to update the user's displayname: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
        }
    }
    
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}






