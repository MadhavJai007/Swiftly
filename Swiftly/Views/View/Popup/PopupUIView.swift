//
//  PopupUIView.swift
//  Swiftly
//
//  Created by Madhav Jaisankar on 2021-10-18.
//

import SwiftUI

struct PopupUIView: View {
    
    var title: String
    var message: String
    var buttonText: String
    @Binding var showPopup: Bool
    
    @State var classCode: String = ""
    
    // holds view of the popup window.
    /// TODO: Generalize it for many purposes
    var body: some View {
        
        ZStack{
            if showPopup {
                // PopUp background color
                Color.black.opacity(showPopup ? 0.9 : 0).edgesIgnoringSafeArea(.all)
                
                // PopUp Window
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 35))
                        .background(Color.whiteCustom)
                    
                    TextField("Enter class code", text: $classCode)
                        .font(.system(size: 20))
                        .background(Color.lightGrayCustom)
                        .frame(height: 45)
                        .padding(15)
                        .foregroundColor(Color.blackCustom)
                        .cornerRadius(15)
                        

                    Button(action: {
                        // Dismiss the PopUp
                        withAnimation(.linear(duration: 0.3)) {
                            showPopup = false
                        }
                    }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .background(Color.lightGrayCustom)
                            .font(Font.system(size: 23, weight: .semibold))
                    }).buttonStyle(PlainButtonStyle())
                }
                .frame(maxWidth: 300)
                .background(Color.whiteCustom)
                .cornerRadius(15)
                
            }
        }
    }
}


