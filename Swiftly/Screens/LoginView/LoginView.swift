//  INFO49635 - CAPSTONE FALL 2021
//  LoginScreen.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.

import SwiftUI
import Firebase

/// TODO: Disable login fields, login button, and signup button when the login
/// loading (showing progress view)

struct LoginView: View {
    
    @State var isNavigationBarHidden: Bool = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var loginViewModel: LoginViewModel /// view model for this view
    @EnvironmentObject var signupViewModel: SignupViewModel
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    Spacer()
                    
                    TitleLabel(text:"Swiftly")
                    
                    VStack(spacing: 25){
                        
                        TextField("Appleseed@example.com", text: $email)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color.white)
                            .foregroundColor(Color.blackCustom)
                            .cornerRadius(15)
                        
                        SecureField("Iloveapples123", text: $password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color.white)
                            .foregroundColor(Color.blackCustom)
                            .cornerRadius(15)
                    }
                    
                    /// Button for logging in --> calls login() from loginViewModel
                    Button(){
                        
                        loginViewModel.login(email: email, password: password)
                        userAccountViewModel.logoutSuccessful = false // --> might not need this?
                        
                        email = ""
                        password = ""
                        
                        
                        
                        /// If the login is successful, download chapter content
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            print("Logging into \(loginViewModel.accountMode) mode...")
                            if (loginViewModel.isSuccessful) {
                                chaptersViewModel.getChapterDocs()
                            }
                            
                            /// Todo: Download user account information here too.
                        }
                        
                    }label: {
                        LoginSignupButton(text: "Login", textColor: .white, backgroundColor: Color.blackCustom)
                    }
                    .padding(.top,50)
                    .padding(.bottom,50)
                    
                    /// Alert for bad login
                    .alert(isPresented: $loginViewModel.isBadLogin) {
                        Alert(title: Text("Oops!"), message: Text("Email and/or password are incorrect."), dismissButton: .default(Text("OK")))
                    }
                    
                    /// Alert for when chapters could not be loaded
                    .alert(isPresented: $chaptersViewModel.didErrorOccurGrabbingData) {
                        Alert(title: Text("Uh-Oh"), message: Text("There was an error loading chapters. Please try again later."), dismissButton: .default(Text("OK")))
                    }
                    
                    
                    
                    
                    /// Navigation link for chapters view --> is only toggled when chapters view model is
                    /// finished downloading chapters from remote db.
                    NavigationLink(destination: ChaptersView()
                                    .environmentObject(loginViewModel)
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(leaderboardViewModel),
                                   isActive: $chaptersViewModel.isUserLoggedIn) {EmptyView()}
                    
                    Spacer()
                    Spacer()
                    
                    VStack(spacing: 20){
                        Text("Need an account?")
                            .font(.system(size: 25, weight: .light))
                            .foregroundColor(.white)
                        
                        
                        Button{
                            loginViewModel.isShowingSignupView.toggle()
                        }label: {
                            
                            LoginSignupButton(text: "Tap to sign up", textColor: .white, backgroundColor: Color.blackCustom)
                        }
                        .padding(.bottom, 50)
                        
                        /// Navigation for signup view
                        NavigationLink(destination: SignupView()
                                        .environmentObject(loginViewModel)
                                        .environmentObject(signupViewModel)
                                        .environmentObject(chaptersViewModel)
                                        .environmentObject(chapterContentViewModel),
                                       isActive: $loginViewModel.isShowingSignupView) {EmptyView()}
                    }
                }
                
                /// Shows progress loader while chapters are being downloaded
                if (loginViewModel.isSuccessful == true){
                    
                    ZStack {
                        
                        Color.blackCustom
                        
                        VStack{
                            ProgressView {
                                Text("Loading")
                                    .foregroundColor(Color.whiteCustom)
                                    .font(.system(size: 20))
                            }
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        }
                    }
                    .frame(width: 150, height: 115)
                    .cornerRadius(20)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white)
        
        .onAppear{
            chaptersViewModel.isUserLoggedIn = false
        }
        
        .onDisappear {
            self.email = ""
            self.password = ""
        }
    }
}

// Preview 
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

// Struct representing the title label
struct TitleLabel: View {
    
    var text: String
    var body: some View {
        
        Text(text)
            .font(.system(size: 75,
                          weight: .semibold))
            .foregroundColor(.white)
            .padding(.bottom, 100)
    }
}


// Struct representing the label on a button
struct LoginSignupButton: View {
    
    var text: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 35))
            .fontWeight(.semibold)
            .padding()
            .frame(width: 400, height: 75)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(15)
    }
}
