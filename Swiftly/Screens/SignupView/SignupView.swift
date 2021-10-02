//  INFO49635 - CAPSTONE FALL 2021
//  SignupView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-24.

import SwiftUI

struct SignupView: View {
    
    var userTypes = ["Student", "Teacher"]
    @State private var selectedType = "Student"
    
    @State private var placeholder = "Placeholder"
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                // Background
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack {
                
                    // Title
                    Text("Account Creation")
                        .font(.system(size: 75,design: .serif))
                        .foregroundColor(.white)
                        .padding(.bottom, geometry.size.width/42)
                        .padding(.top, -geometry.size.width/42)
                    
                    // Username
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"First Name")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        SignupInputField(placeholderText: "Username", width: geometry.size.width - 150, height: geometry.size.width/12, stateAttribute: placeholder)
                    }.padding(.bottom, geometry.size.width/42)
                    
                    
                    
                    // First and last name
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                           
                            InputFieldLabel(text:"First Name")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            SignupInputField(placeholderText: "First Name", width: geometry.size.width/2 - 100, height: geometry.size.width/12, stateAttribute: placeholder)
                        }
                        
                        VStack(alignment: .leading) {
                           
                            InputFieldLabel(text:"Last Name")
                                .padding(.bottom, -geometry.size.width/120)

                            SignupInputField(placeholderText: "Last Name", width: geometry.size.width/2 - 100, height: geometry.size.width/12, stateAttribute: placeholder)
                        }
                    }.padding(.bottom, geometry.size.width/42)
                    
                    // Country and DOB
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            
                            InputFieldLabel(text:"Country")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            SignupInputField(placeholderText: "Country", width: geometry.size.width/2 - 100, height: geometry.size.width/12, stateAttribute: placeholder)
                            
                            
                        }
                        
                        VStack(alignment: .leading) {
                            
                            InputFieldLabel(text:"Date of Birth")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            SignupInputField(placeholderText: "Date of Birth", width: geometry.size.width/2 - 100, height: geometry.size.width/12, stateAttribute: placeholder)
                        }
                    }.padding(.bottom, geometry.size.width/42)
                    
                    // Email Address
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Email Address")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        SignupInputField(placeholderText: "Email Address", width: geometry.size.width - 150, height: geometry.size.width/12, stateAttribute: placeholder)
                        
                    }.padding(.bottom, geometry.size.width/42)
                    
                    // Password
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Password")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        SignupInputField(placeholderText: "Password", width: geometry.size.width - 150, height: geometry.size.width/12, stateAttribute: placeholder)
                        
                    }.padding(.bottom, geometry.size.width/42)
                    
                    HStack{
                        
                        InputFieldLabel(text:"User Type: ")
                        
                        
                        Picker("", selection: $selectedType) {
                                        ForEach(userTypes, id: \.self) {
                                                       
                                            Text($0)
                                                .font(.system(size: 30))
                                        }
                                    }
                        .frame(width: 100, height: 50)
                        .background(Color.blackCustom)
                        .cornerRadius(15)
                        
                    }
                    
                    // Create account button
                    Button{
                        self.mode.wrappedValue.dismiss()
                    }label:{
                        CreateAccountButton(text: "Create Account", textColor: .white, backgroundColor: Color.blackCustom)
                            .padding(geometry.size.width/42)
                    }
                    
                    
                    
                }
                
                Spacer()
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
