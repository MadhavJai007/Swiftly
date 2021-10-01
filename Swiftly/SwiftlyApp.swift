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
    var chapterDetailsViewModel: ChapterDetailViewModel
    
    init(){
        FirebaseApp.configure()
        loginViewModel = LoginViewModel()
        chaptersViewModel = ChaptersViewModel()
        chapterDetailsViewModel = ChapterDetailViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(loginViewModel)
                .environmentObject(chaptersViewModel)
        }
    }
}
