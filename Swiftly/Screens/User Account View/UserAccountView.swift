//  INFO49635 - CAPSTONE FALL 2021
//  UserAccountView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-03.

/// Todo: Add functionality that will allow the user to logout. This will change a variable that will pop this view, and ChaptersView.


import SwiftUI

struct UserAccountView: View {
    
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel // view model for this view
    
    var body: some View {
        
        ZStack{
            
            Color.darkGrayCustom
                .ignoresSafeArea()
            
            VStack{
                
                Text("User Account View")
                    .foregroundColor(.white)
            }
            
            
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
    }
}
