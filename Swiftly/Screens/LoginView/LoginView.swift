//  INFO49635 - CAPSTONE FALL 2022
//  LoginScreen.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI
import Firebase

struct LoginView: View {
    
    @ObservedObject var monitor = NetworkMonitor()
    
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
                
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                 
                VStack {
                    
                    VStack{
                        TitleLabel(text: "Swiftly")
                            .accessibilityLabel("Swiftly")
                    }
                    .frame(alignment: .topLeading)
                    .padding(.top, 250)
                    
                    VStack(spacing: 25){
                        TextField("Email Address", text: $email)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color(UIColor.systemGray3))
                            .autocapitalization(.none)
                            .cornerRadius(15)
                            .accessibilityLabel("Email Address")
                        
                        SecureInputView("Password", text: $password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color(UIColor.systemGray3))
                            .cornerRadius(15)
                            .accessibilityLabel("Password")
                    }
                    
                    
                    /// Login button --> calls login method from loginViewModel
                    Button{
                        print("Logging into \(loginViewModel.accountMode) mode...")
                        
                        loginViewModel.isLoading.toggle()
                        
                        /// Used to make sure user cannot hit login button while their being logged in
                        if (loginViewModel.attemptingLogin == false){
                            loginViewModel.login(email: email, password: password)

                            /// If the login is successful, download chapter content 
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                
                                if (loginViewModel.isSuccessful) {
                                    
                                    loginViewModel.loggedInEmail = email
                                    
                                    print("Loggin into \(loginViewModel.loggedInEmail)")
                                    print("Logging into \(loginViewModel.accountMode) mode...")
                                    
                                    /// Loading all user data
                                    chaptersViewModel.loadUserData(loggedInEmail: email, accountType: loginViewModel.accountMode)
                                    
                                    email = ""
                                    password = ""
                                    
                                    loginViewModel.attemptingLogin = true
                                    
                                }else{
                                    /// Error getting chapters
                                    loginViewModel.attemptingLogin = false
                                    loginViewModel.isLoading = false
                                }
                            }
                        }
                    }label: {
                        ButtonLabelLarge(text: "Login", textColor: .white, backgroundColor: Color(UIColor.systemGray2))
                            .accessibilityLabel("Login")
                    }
                    .padding(.top,50)
                    .padding(.bottom,50)
                    .opacity(loginViewModel.isLoading || !monitor.isConnected ? 0.24 : 1)
                    .disabled(loginViewModel.isLoading || !monitor.isConnected)
                    
                    /// Alert for bad login
                    .alert(item: $loginViewModel.alertInfo, content: { info in
                        Alert(title: Text(info.title), message: Text(info.message))
                    })
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
                            .accessibilityLabel("Need an account?")
                        Button{
                            /// Only let the user tap the sign up button when the user is not trying
                            /// to login.
                            if (loginViewModel.attemptingLogin == false){
                                loginViewModel.isShowingSignupView.toggle()
                            }
                        }label: {
                            ButtonLabelLarge(text: "Tap to sign up", textColor: .white, backgroundColor: Color(UIColor.systemGray2))
                                .accessibilityLabel("Tap to sign up")
                        }
                        
                        /// Navigation for signup view
                        NavigationLink(destination: SignupView()
                                        .environmentObject(loginViewModel)
                                        .environmentObject(signupViewModel)
                                        .environmentObject(chaptersViewModel)
                                        .environmentObject(chapterContentViewModel),
                                       isActive: $loginViewModel.isShowingSignupView) {EmptyView()}
                    }
                    if (!monitor.isConnected){
                        Text("Connect to the internet before attempting to login")
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                            .accessibilityLabel("Connect to the internet before attempting to login")
                    }
                    Spacer()
                }
                .padding(.bottom, 250)
                
                /// Shows progress loader while chapters are being downloaded
                if (loginViewModel.isSuccessful == true){
                    ZStack {
                        Color.blackCustom
                        
                        VStack{
                            ProgressView {
                                SpinnerInfoLabel(text:chaptersViewModel.loadingInfo)
                            }
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        }
                    }
                    .frame(width: 175, height: 125)
                    .cornerRadius(15)
                    .animation(.spring())
                }
            }
            .animation(.spring())
            
            .onAppear{
                email = ""
                password = ""
                chaptersViewModel.isUserLoggedIn = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    chaptersViewModel.chaptersArr.removeAll()
                    chaptersViewModel.clearAllData()
                    chaptersViewModel.downloadLessons()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        chaptersViewModel.downloadPlaygrounds()
                    }
                }
            }
            
            /// Resetting user input
            .onDisappear {
                self.email = ""
                self.password = ""
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .accentColor(.white)
    }
}

/// Preview
struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
