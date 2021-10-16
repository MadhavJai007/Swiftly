//  INFO49635 - CAPSTONE FALL 2021
//  SignupView.swift
//  Swiftly

import SwiftUI

struct SignupView: View {
    
    var userTypes = ["Student", "Teacher"]
    @State private var selectedType = "Student"
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var signupViewModel: SignupViewModel /// view model for this view
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            ZStack {
                
                // Background
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Button{
                            loginViewModel.isShowingSignupView.toggle()
                        }label:{
                            NavBarIcon(iconName: "chevron.backward")
                        }
                        .padding(.leading, 30)

                        Spacer()
                    }
                    .padding(.top, geometry.size.width/24)
                    .padding(.bottom, geometry.size.width/24)
                    
                    // Title
                    Text("Account Creation")
                        .font(.system(size: 75))
                        .foregroundColor(.white)
                        .padding(.bottom, geometry.size.width/42)
                    
                    // Username
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Username")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Username", text : $signupViewModel.newUser.username)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color.white)
                            .foregroundColor(.darkGrayCustom)
                            .cornerRadius(15)
                        
                    }
                    .padding(geometry.size.width/42)
                         
                    
                    // First and last name
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                           
                            InputFieldLabel(text:"First Name")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            
                            TextField("First Name", text : $signupViewModel.newUser.firstName)
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

                            TextField("Last Name", text : $signupViewModel.newUser.lastName)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color.white)
                                .foregroundColor(.darkGrayCustom)
                                .cornerRadius(15)
                        }
                    }.padding(geometry.size.width/42)
                    
                    // Country and DOB
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            
                            InputFieldLabel(text:"Country")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            TextField("Country", text : $signupViewModel.newUser.country)
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
                            
                            TextField("DD/MM/YYYY", text : $signupViewModel.newUser.dob)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color.white)
                                .foregroundColor(.darkGrayCustom)
                                .cornerRadius(15)
                        }
                    }
                    .padding(geometry.size.width/42)
                    
                    // Email Address
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Email Address")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Email", text : $signupViewModel.newUser.email)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color.white)
                            .foregroundColor(.darkGrayCustom)
                            .cornerRadius(15)
                        
                    }
                    .padding(geometry.size.width/42)
                    
                    // Password
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Password")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Password", text : $signupViewModel.newUser.password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color.white)
                            .foregroundColor(.darkGrayCustom)
                            .cornerRadius(15)
                        
                    }
                    .padding(geometry.size.width/42)
                    
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
                        createAccount(accountType: selectedType)
                    }label:{
                        CreateAccountButton(text: "Create Account", textColor: .white, backgroundColor: Color.blackCustom)
                            .padding(geometry.size.width/42)
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
    
    func createAccount(accountType: String) {
        signupViewModel.save(accountType: accountType)
        
        loginViewModel.isShowingSignupView.toggle()
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
