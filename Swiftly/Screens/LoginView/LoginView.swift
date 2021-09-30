//  INFO49635 - CAPSTONE FALL 2021
//  LoginScreen.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.

/// All @ variables are temporary as of right now (2021-09-24).
/// Once the functionality is implemented they will be modified.

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var placeholder: String = ""
    
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    
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
                        
                        TextField("Iloveapples123", text: $password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: 400, height: 75)
                            .background(Color.white)
                            .foregroundColor(Color.blackCustom)
                            .cornerRadius(15)
                    }
                    
                    Button(){
                        viewModel.login(email: email, password: password)
                        
                    }label: {
                        LoginSignupButton(text: "Login", textColor: .white, backgroundColor: Color.blackCustom)
                    }
                    .padding(.top,50)
                    .padding(.bottom,50)
                    
                    NavigationLink(destination: ChaptersView(), isActive: $viewModel.isSuccessful) {EmptyView()}
                    
                    Spacer()
                    Spacer()
                    
                    
                    VStack(spacing: 20){
                        Text("Need an account?")
                            .font(.system(size: 25, weight: .light))
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: SignupView()) {
                            LoginSignupButton(text: "Tap to sign up", textColor: .white, backgroundColor: Color.blackCustom)
                            
                            
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white)
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
                          weight: .semibold, design: .serif))
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
