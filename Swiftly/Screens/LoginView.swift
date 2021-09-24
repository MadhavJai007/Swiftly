//
//  LoginScreen.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    Spacer()
                    
                    Text("Swiftly")
                        .font(.system(size: 75,
                                      weight: .semibold, design: .serif))
                        .foregroundColor(.white)
                        .padding(.bottom, 100)
                    
                    VStack(spacing: 25){
                        
                        LoginInputTextField(placeholderText: "Username", stateAttribute: username)
                        
                        LoginInputTextField(placeholderText: "Password", stateAttribute: password)
                    }
                                        
                    Button {
                        print("login")
                    }label: {
                        LoginSignupButton(text: "Login", textColor: .white, backgroundColor: Color.blackCustom)
                    }
                    .padding(.top,50)
                    .padding(.bottom,50)
                    
                    Spacer()
                    Spacer()
                    
                    
                    VStack(spacing: 20){
                        Text("Need an account?")
                            .font(.system(size: 25, weight: .light))
                            .foregroundColor(.white)
                        
                        NavigationLink(
                            destination: SignupView()){
                            
                            LoginSignupButton(text: "Tap to sign up", textColor: .white, backgroundColor: Color.blackCustom)
                            
                        }
                    }
                    .padding(.bottom, 50)
                }
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
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


// Struct representing input text field
struct LoginInputTextField: View {
    
    var placeholderText: String
    @State var stateAttribute: String
    
    var body: some View {
        
        TextField(placeholderText, text: $stateAttribute)
            .font(.system(size: 30))
            .padding()
            .frame(width: 400, height: 75)
            .background(Color.white)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}
