//  INFO49635 - CAPSTONE FALL 2021
//  SignupView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.

/// All @ variables are temporary as of right now (2021-09-24).
/// Once the functionality is implemented they will be modified.

import SwiftUI

struct SignupView: View {
    
    @State private var placeholder = "Placeholder"
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                // Background
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    
                    // Title
                    Text("Account Creation")
                        .font(.system(size: 75,design: .serif))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    
                    // Username
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"First Name")
                        
                        SignupInputField(placeholderText: "Username", width: geometry.size.width - 150, height: 75, stateAttribute: placeholder)
                    }.padding(.bottom, 25)
                    
                    
                    
                    // First and last name
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                           
                            InputFieldLabel(text:"First Name")
                            
                            SignupInputField(placeholderText: "First Name", width: geometry.size.width/2 - 100, height: 75, stateAttribute: placeholder)
                            
                            
                        }
                        
                        VStack(alignment: .leading) {
                           
                            InputFieldLabel(text:"Last Name")

                            SignupInputField(placeholderText: "Last Name", width: geometry.size.width/2 - 100, height: 75, stateAttribute: placeholder)
                        }
                    }.padding(.bottom, 25)
                    
                    // Country and DOB
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            
                            InputFieldLabel(text:"Country")
                            
                            SignupInputField(placeholderText: "Country", width: geometry.size.width/2 - 100, height: 75, stateAttribute: placeholder)
                            
                            
                        }
                        
                        VStack(alignment: .leading) {
                            
                            InputFieldLabel(text:"Date of Birth")
                            
                            SignupInputField(placeholderText: "Date of Birth", width: geometry.size.width/2 - 100, height: 75, stateAttribute: placeholder)
                        }
                    }.padding(.bottom, 25)
                    
                    // Email Address
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Email Address")
                        
                        SignupInputField(placeholderText: "Email Address", width: geometry.size.width - 150, height: 75, stateAttribute: placeholder)
                        
                    }.padding(.bottom, 25)
                    
                    // Password
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Password")
                        
                        SignupInputField(placeholderText: "Password", width: geometry.size.width - 150, height: 75, stateAttribute: placeholder)
                    }

                    Spacer()
                    
                    // Create account button
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

// Preview
struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

// Struct representing input field label
struct InputFieldLabel: View {
    
    var text:String
    
    var body: some View {
        
        Text(text)
            .foregroundColor(.white)
            .font(.system(size: 25))
        
    }
}


// Struct representing input text field
struct SignupInputField: View {
    
    var placeholderText: String
    var width: CGFloat
    var height: CGFloat

    @State var stateAttribute: String

    var body: some View {
        
        TextField(placeholderText, text: $stateAttribute)
            .font(.system(size: 30))
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
