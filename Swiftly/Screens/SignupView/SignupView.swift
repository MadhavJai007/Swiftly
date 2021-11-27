//  INFO49635 - CAPSTONE FALL 2021
//  SignupView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct SignupView: View {
    
    var userTypes = ["Student", "Teacher"]
    var countries = ["Canada", "United States", "United Kingdom", "Australia"]
    @State private var selectedType = "Student"
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var signupViewModel: SignupViewModel /// view model for this view
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color(UIColor.systemGray6)
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
                    TitleLabel(text:"Account Creation")
                        .padding(.bottom, geometry.size.width/42)
                    
                    // Username
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Username")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Username", text : $signupViewModel.newUser.username)
                            .font(.system(size: 30))
                            .padding()
                            .autocapitalization(.none)
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color(UIColor.systemGray3))
                            .cornerRadius(15)
                        Text("Must be 5-15 characters in length, start with a letter and only contain a _ or . after a letter.")
                            .font(.system(size: 15))
                        
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
                                .autocapitalization(.none)
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color(UIColor.systemGray3))
                                .cornerRadius(15)
                        }
                        
                        VStack(alignment: .leading) {
                           
                            InputFieldLabel(text:"Last Name")
                                .padding(.bottom, -geometry.size.width/120)

                            TextField("Last Name", text : $signupViewModel.newUser.lastName)
                                .font(.system(size: 30))
                                .padding()
                                .autocapitalization(.none)
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color(UIColor.systemGray3))
                                .cornerRadius(15)
                        }
                    }.padding(geometry.size.width/42)
                    
                    // Country and DOB
                    HStack(spacing:geometry.size.width/18){
                        
                        VStack(alignment: .leading){
                            
                            InputFieldLabel(text:"Country")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            Picker("", selection: $signupViewModel.newUser.country) {
                                            ForEach(countries, id: \.self) {
                                                           
                                                Text($0)
                                                    .font(.system(size: 30))
                                            }
                                        }
                            .frame(width: 100, height: 50)
                            .background(Color(UIColor.systemGray3))
                            .cornerRadius(10)
                            
                        }
                        
                        VStack(alignment: .leading) {
                            
                            InputFieldLabel(text:"Date of Birth")
                                .padding(.bottom, -geometry.size.width/120)
                            
                            
                            
                            TextField("DD/MM/YYYY", text : $signupViewModel.newUser.dob)
                                .font(.system(size: 30))
                                .padding()
                                .frame(width: geometry.size.width/2 - 100, height: geometry.size.width/12)
                                .background(Color(UIColor.systemGray3))
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
                            .autocapitalization(.none)
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color(UIColor.systemGray3))
                            .cornerRadius(15)

                        
                    }
                    .padding(geometry.size.width/42)
                    
                    // Password
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Password")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        SecureInputView("Password", text : $signupViewModel.newUser.password)
                            .font(.system(size: 30))
                            .padding()
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color(UIColor.systemGray3))
                            .cornerRadius(15)
                        Text("Must be 8-15 characters in length, start with a letter, and contain atleast 1 number")
                            .font(.system(size: 15))
                        
                    }
                    .padding(geometry.size.width/42)
                    
                    /*
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
                     */
                    
                    // Create account button
                    Button{
                        signupViewModel.save(accountType: selectedType)

                        let timer2 = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] (timer) in
                            if(signupViewModel.emailNotTaken == true){
                                loginViewModel.isShowingSignupView.toggle()
                            }
                                
                        }
                    }label:{
                        CreateAccountButton(text: "Create Account", textColor: .white, backgroundColor: Color.blackCustom)
                            .padding(geometry.size.width/42)
                        
                    }
                    .opacity(signupViewModel.isSignUpComplete ? 1 : 0.6)
                    .disabled(!signupViewModel.isSignUpComplete)
                    .alert(isPresented: $signupViewModel.isBadSignup) {
                        Alert(title: Text("Email Already Taken"), message: Text("\(signupViewModel.newUser.email) is already taken."), dismissButton: .default(Text("OK")))
                            
                            

                    }
                }
                Spacer()
                
                    .onAppear(){
                        signupViewModel.chaptersArr = chaptersViewModel.chaptersArr
                    }
            }
            .navigationBarHidden(true)
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
            .background(Color(UIColor.systemGray2))
            .cornerRadius(15)
    }
}


struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
            }
        }
    }
}
