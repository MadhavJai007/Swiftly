//
//  SignupView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.
//

import SwiftUI

struct SignupView: View {
    
    @State private var placeholder = "Placeholder"
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
        
            ZStack {
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
            
                VStack {
                    
                    Spacer()
                    
                    Text("Account Creation")
                        .font(.system(size: 75,design: .serif))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    

                    // Username
                    VStack(alignment: .leading){
                        Text("Username")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                        
                        SignupInputTextField(placeholderText: "Username", width: geometry.size.width - 150, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                    }.padding(.bottom, 25)
                    
                    
                    
                    // First and last name
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            Text("First Name")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            
                            SignupInputTextField(placeholderText: "First Name", width: geometry.size.width/2 - 100, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                            
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Last Name")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            
                            SignupInputTextField(placeholderText: "Last Name", width: geometry.size.width/2 - 100, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                        }
                    }.padding(.bottom, 25)
                    
                    // Country and DOB
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            Text("Country")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            
                            SignupInputTextField(placeholderText: "Country", width: geometry.size.width/2 - 100, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                            
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Date of Birth")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            
                            SignupInputTextField(placeholderText: "Date of Birth", width: geometry.size.width/2 - 100, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                        }
                    }.padding(.bottom, 25)
                    
                    // Email Address
                    VStack(alignment: .leading){
                        Text("Email Address")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                        
                        SignupInputTextField(placeholderText: "Email Address", width: geometry.size.width - 150, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                    }.padding(.bottom, 25)
                    
                    // Password
                    VStack(alignment: .leading){
                        Text("Password")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                        
                        SignupInputTextField(placeholderText: "Password", width: geometry.size.width - 150, height: 75, fontSize: 30.0, stateAttribute: placeholder)
                    }
                    
                    
                    Spacer()
                    
                    Button{
                        self.mode.wrappedValue.dismiss()
                    }label:{
                        CreateAccountButton(text: "Create Account", textColor: .white, backgroundColor: Color.blackCustom)
                            .padding(50)
                    }
                    
                }
            }
        }
            
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


// Struct representing input text field
struct SignupInputTextField: View {
    
    var placeholderText: String
    var width: CGFloat
    var height: CGFloat
    var fontSize: CGFloat

    
    @State var stateAttribute: String
    
    
    
    var body: some View {
        
        TextField(placeholderText, text: $stateAttribute)
            .font(.system(size: fontSize))
            .padding()
            .frame(width: width, height: height)
            .background(Color.white)
            .foregroundColor(.darkGrayCustom)
            .cornerRadius(15)
    }
}


// Struct representing the label on a button
struct CreateAccountButton: View {
    
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
