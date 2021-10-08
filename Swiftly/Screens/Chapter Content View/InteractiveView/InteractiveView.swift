//
//  InteractiveView.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-08.
//

import SwiftUI


struct InteractiveView: View {
    
    // Used to manually pop from nav view stack
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.blackCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack {
                        
                        Button{
                            self.mode.wrappedValue.dismiss()
                        }label:{
                            ChapterNavBarIcon(iconName: "xmark")
                            
                        }
                        .padding(.leading, 30)
                        
                        Spacer()
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/32)
                    
                    Spacer()
                    
                    ZStack{
                        Color.darkGrayCustom
                            .ignoresSafeArea()
                    
                        
                        HStack{
                            
                            VStack(alignment: .leading){
                                InteractiveSubTitle(text:"Challenge")
                                InteractiveContentText(text:"Your challenge is to reconstruct the code for X that you learned about in the previous section.")
                                
                                Spacer()
                            }.frame(width: geometry.size.width/1.5)
                                .padding(.top, 30)
                                
                            
        
                            VStack(alignment: .center){
                                Button{
                                    print("Submit")
                                }label: {
                                    InteractiveSubTitle(text: "Submit")
                                }
                                .frame(width: geometry.size.width/5, height: geometry.size.width/10)
                                .background(Color.blackCustom)
                                .cornerRadius(15)
                                
                            }.frame(width: geometry.size.width/4, alignment: .center)
                        }
                        
                    }
                    
                    .frame(width: geometry.size.width, height: geometry.size.height/5)
                }    
            }
        }
        .navigationBarHidden(true)
    }
}

struct InteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveView()
    }
}


struct InteractiveSubTitle: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 40,
                          weight: .bold,
                          design: .default))
            .foregroundColor(Color.white)
    }
}


struct InteractiveContentText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 30))
            .foregroundColor(Color.white)
    }
}
