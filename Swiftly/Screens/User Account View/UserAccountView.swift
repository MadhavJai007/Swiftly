//  INFO49635 - CAPSTONE FALL 2021
//  UserAccountView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-03.

/// Todo: Add functionality that will allow the user to logout. This will change a variable that will pop this view, and ChaptersView.

/// Todo: Hide navigation bar, add back button and settings button that will allow user to edit their account.

import SwiftUI

struct UserAccountView: View {
    
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel // view model for this view
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    Spacer()
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: geometry.size.width/20){
                            
                            UserAccountTitleLabel(text: "About Me", color: Color.whiteCustom)
                            
                            VStack(alignment: .leading){
                                InfoHeader(text:"Username")
                                InfoLabel(text: MockData.sampleUser.username)
                            }
                            
                            VStack(alignment: .leading){
                                InfoHeader(text:"Name")
                                InfoLabel(text: "\(MockData.sampleUser.firstName) \(MockData.sampleUser.lastName)")
                            }
                            
                            VStack(alignment: .leading){
                                InfoHeader(text:"Country")
                                InfoLabel(text: MockData.sampleUser.country)
                            }
                            
                            VStack(alignment: .leading){
                                InfoHeader(text:"Date of Birth")
                                InfoLabel(text: MockData.sampleUser.dob)
                            }
                            
                            VStack(alignment: .leading){
                                InfoHeader(text:"Email Address")
                                InfoLabel(text: MockData.sampleUser.email)
                            }
                            
                            VStack(alignment: .leading){
                                InfoHeader(text:"Password")
                                InfoLabel(text: MockData.sampleUser.password)
                            }
                            
                            Spacer()
                        }
                        .frame(width: geometry.size.width/2, alignment: .leading)
                        .padding(.leading, geometry.size.width/24)
                        
                        Spacer()
                        
                        ZStack(alignment: .leading){
                            
                            Color.whiteCustom
                            
                            VStack(alignment: .leading){
                                
                                UserAccountTitleLabel(text: "Progress", color: Color.darkGrayCustom)
                                    
                                Spacer()

                            }.padding(.leading, geometry.size.width/24)
                            
                            
                        }.frame(width: geometry.size.width/2, height: geometry.size.height/1.15, alignment: .leading)
                            .cornerRadius(40)
                            .padding(.trailing, -geometry.size.width/24)
                        
                    }
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/1.15)
            }
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
    }
}


// Struct representing the title label
struct UserAccountTitleLabel: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 75,
                          weight: .medium, design: .default))
            .foregroundColor(color)
    }
}


// Struct for the info header
struct InfoHeader: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 28))
            .foregroundColor(Color.whiteCustom)
    }
}

// Struct for the info label
struct InfoLabel: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 35, weight: .semibold))
            .foregroundColor(Color.whiteCustom)
    }
}
