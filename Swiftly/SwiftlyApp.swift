//  INFO49635 - CAPSTONE FALL 2021
//  SwiftlyApp.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.

import SwiftUI
import UIKit
import Firebase
    
@main
struct SwiftlyApp: App {
    
    // Creating view models as environment objects
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var signupViewModel = SignupViewModel()
    @StateObject var chaptersViewModel = ChaptersViewModel()
    @StateObject var chapterContentViewModel = ChapterContentViewModel()
    
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            // Passing the environment objects down the hierarchy
            LoginView()
                .environmentObject(loginViewModel)
                .environmentObject(signupViewModel)
                .environmentObject(chaptersViewModel)
                .environmentObject(chapterContentViewModel)
        }
    }
}
