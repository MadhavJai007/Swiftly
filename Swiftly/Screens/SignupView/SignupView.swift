//  INFO49635 - CAPSTONE FALL 2021
//  SignupView.swift
//  Swiftly

import SwiftUI

struct SignupView: View {
    
    var userTypes = ["Student", "Teacher"]
    @State private var selectedType = "Student"
    
    @State private var placeholder = "Placeholder"
    
    @StateObject var viewModel = SignupViewModel()
    
    
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
                        
                        InputFieldLabel(text:"Username")
                            .padding(.bottom, -geometry.size.width/120)
                        

                    
                        TextField("Username", text : $viewModel.newUser.username)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color.white)
                            .foregroundColor(.darkGrayCustom)
                            .cornerRadius(15)
                        
                    }
                    
                    
                    
                    // First and last name
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                           
                            InputFieldLabel(text:"First Name")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            
                            TextField("First Name", text : $viewModel.newUser.firstName)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color.white)
                                .foregroundColor(.darkGrayCustom)
                                .cornerRadius(15)
                        }
                        
                        VStack(alignment: .leading) {
                           
                            InputFieldLabel(text:"Last Name")
                                .padding(.bottom, -geometry.size.width/120)

                            TextField("Last Name", text : $viewModel.newUser.lastName)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color.white)
                                .foregroundColor(.darkGrayCustom)
                                .cornerRadius(15)
                        }
                    }.padding(.bottom, geometry.size.width/42)
                    
                    // Country and DOB
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            
                            InputFieldLabel(text:"Country")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            TextField("Country", text : $viewModel.newUser.country)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color.white)
                                .foregroundColor(.darkGrayCustom)
                                .cornerRadius(15)
                            
                            
                        }
                        
                        VStack(alignment: .leading) {
                            
                            InputFieldLabel(text:"Date of Birth")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            TextField("Date of Birth", text : $viewModel.newUser.dob)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color.white)
                                .foregroundColor(.darkGrayCustom)
                                .cornerRadius(15)
                        }
                    }.padding(.bottom, geometry.size.width/42)
                    
                    // Email Address
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Email Address")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Email", text : $viewModel.newUser.email)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color.white)
                            .foregroundColor(.darkGrayCustom)
                            .cornerRadius(15)
                        
                    }.padding(.bottom, geometry.size.width/42)
                    
                    // Password
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Password")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Password", text : $viewModel.newUser.password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color.white)
                            .foregroundColor(.darkGrayCustom)
                            .cornerRadius(15)
                        
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
                        //create newUsser variable to push to database
                        createAccount()
                    }label:{
                        CreateAccountButton(text: "Create Account", textColor: .white, backgroundColor: Color.blackCustom)
                            .padding(geometry.size.width/42)
                    }
                }
                Spacer()
            }
        }
            
    }
    
    func createAccount() {
        viewModel.save()
        self.mode.wrappedValue.dismiss()
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

