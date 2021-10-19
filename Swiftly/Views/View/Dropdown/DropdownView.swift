//
//  DropdownView.swift
//  Swiftly
//
//  Created by Madhav Jaisankar on 2021-10-18.
//

import SwiftUI

struct DropdownView: View {
    @State var expand = false
    
    // The view is used to make a dropdown menu that can be used for different purposes
    var body: some View {
//        ZStack{
        VStack(){
            VStack(spacing: 30){
                HStack {
                    Text("Select account type")
                        .fontWeight(.light)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 20, height: 9)
                        .foregroundColor(.whiteCustom)
                }.onTapGesture {
                    self.expand.toggle()
                }
                // when the dropdown menu is expanded, show the options
                if expand {
                    Button(action: {
                        print("Student sign in chosen")
                        self.expand.toggle()
                    }){
                        Text("Student")
                            .fontWeight(.semibold)
                            .font(.system(size: 30))
                            .padding()
                    }.foregroundColor(.whiteCustom)
                    Button(action: {
                        print("Teacher sign in chosen")
                        self.expand.toggle()
                    }){
                        Text("Teacher")
                            .fontWeight(.semibold)
                            .font(.system(size: 30))
                            .padding()
                    }.foregroundColor(.whiteCustom)
                    
                }
                
            }
            .frame(minWidth: 400, idealWidth: 400, maxWidth: 400)
            .padding()
            .background(Color.blackCustom)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 2)
            .animation(.spring())
        }
//        }
    }
}

