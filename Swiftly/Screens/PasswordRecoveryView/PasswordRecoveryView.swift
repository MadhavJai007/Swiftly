//
//  PasswordRecoveryView.swift
//  Swiftly
//
//  Created by Arjun Suthaharan on 2022-09-10.
//

import SwiftUI

struct PasswordRecoveryView: View {
    
    @ObservedObject var monitor = NetworkMonitor()
    @State var email = ""
    
    @EnvironmentObject var passwordRecoveryViewModel: PasswordRecoveryViewModel
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Button{
                            passwordRecoveryViewModel.toggleNow.toggle()
                        }label:{
                            NavBarIcon(iconName: "chevron.backward")
                        }
                        .padding(.leading, 30)

                        Spacer()
                    }
                    .padding(.top, geometry.size.width/24)
                    .padding(.bottom, geometry.size.width/24)
                    
                    // Title
                    TitleLabel(text:"Password Recovery")
                        .padding(.bottom, geometry.size.width/42)
                    
                    // Username
                    VStack(alignment: .leading){
                        
                        InputFieldLabel(text:"Email")
                            .padding(.bottom, -geometry.size.width/120)
                        
                        TextField("Email", text: self.$email)
                            .font(.system(size: 30))
                            .padding()
                            .autocapitalization(.none)
                            .frame(width: geometry.size.width - 150, height: geometry.size.width/12)
                            .background(Color(UIColor.systemGray3))
                            .cornerRadius(15)
                    }
                    .padding(geometry.size.width/42)

           
                    VStack(spacing: 20){
                        
                    ///password recovery button
                        Button{
                            print("Button pressed")
                        }label: {
                            ButtonLabelLarge(text: "Reset Password", textColor: .white, backgroundColor: Color(UIColor.systemGray2))
                        }
                    }

                    if (!monitor.isConnected){
                        Text("Connect to the internet if you want to reset password")
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                    }
                    
                }

                Spacer()
                
                    .onAppear(){
                        self.email = ""
 
                    }
            }
            .navigationBarHidden(true)
        }
    }
}

struct PasswordRecoveryView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRecoveryView()
    }
}
