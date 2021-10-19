//  INFO49635 - CAPSTONE FALL 2021
//  LoginScreen.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    var accountTypeOptions = ["Student", "Teacher"]
    
    /// Environment View Models being passed down the hierarchy
    @EnvironmentObject var loginViewModel: LoginViewModel /// --> view model for this view
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
                    
                    VStack{
                        Spacer()
                        Spacer()
                        
                        TitleLabel(text:"Swiftly")
                    }
                    .frame(alignment: .topLeading)
                
                    
                    VStack{
                        DropdownView(optionArray: accountTypeOptions)
                    }
                    .padding()
                    
                    
                    VStack(spacing: 25){
                        
                                                
                        TextField("Email Address", text: $email)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color.white)
                            .foregroundColor(Color.blackCustom)
                            .cornerRadius(15)
                        
                        SecureField("Password", text: $password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color.white)
                            .foregroundColor(Color.blackCustom)
                            .cornerRadius(15)
                    }
                    
                    
                    /// Login button --> calls login method from loginViewModel
                    Button{
                        
                        /// Used to make sure user cannot hit login button while their being logged in
                        if (loginViewModel.attemptingLogin == false){
                            
                            print("Logging into \(loginViewModel.accountMode) mode...")
//                            loginViewModel.attemptingLogin = true
//                            loginViewModel.login(email: email, password: password)
//
//                            email = ""
//                            password = ""
//
//                            /// If the login is successful, download chapter content
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                                print("Logging into \(loginViewModel.accountMode) mode...")
//                                if (loginViewModel.isSuccessful) {
//                                    chaptersViewModel.getChapterDocs()
//                                    loginViewModel.attemptingLogin = true
//                                }else{
//                                    // Error getting chapters
//                                    loginViewModel.attemptingLogin = false
//                                }
//                            }
                        }
                    }label: {
                        ButtonLabelLarge(text: "Login", textColor: .white, backgroundColor: Color.blackCustom)
                    }
                    .padding(.top,50)
                    .padding(.bottom,50)
                    
                    /// Alert for bad login
                    .alert(isPresented: $loginViewModel.isBadLogin) {
                        Alert(title: Text("Bad Login"), message: Text("Email and/or password are incorrect."), dismissButton: .default(Text("OK")))
                    }
                    .animation(.spring())
                    
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
                        InfoLabelMedium(text:"Need an account?")
                        
                        Button{
                            /// Only let the user tap the sign up button when the user is not trying
                            /// to login.
                            if (loginViewModel.attemptingLogin == false){
                                loginViewModel.isShowingSignupView.toggle()
                            }
                            
                        }label: {
                            ButtonLabelLarge(text: "Tap to sign up", textColor: .white, backgroundColor: Color.blackCustom)
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
                                SpinnerInfoLabel(text:"Loading...")
                            }
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        }
                    }
                    .frame(width: 150, height: 115)
                    .cornerRadius(20)
                    .animation(.spring())
                }
            }
            .animation(.spring())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .accentColor(.white)
        
        .onAppear{
            chaptersViewModel.isUserLoggedIn = false
        }
        
        /// Resetting user input
        .onDisappear {
            self.email = ""
            self.password = ""
        }
    }
}

/// Preview
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
