//
//  SwiftlyApp.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-24.
//

import SwiftUI
import UIKit
import Firebase

@main
struct SwiftlyApp: App {
    
    var loginViewModel: LoginViewModel
    var chaptersViewModel: ChaptersViewModel
    
    init(){
        FirebaseApp.configure()
        loginViewModel = LoginViewModel()
        chaptersViewModel = ChaptersViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(loginViewModel)
                .environmentObject(chaptersViewModel)
        }
    }
}
