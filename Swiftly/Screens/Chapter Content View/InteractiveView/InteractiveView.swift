//
//  InteractiveView.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-08.
//

import SwiftUI

/// TODO: Access screen size and find areas that draggable
/// icon are allowed.


struct InteractiveView: View {
    
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @State private var fingerLocation: CGPoint?
    
    // Used to manually pop from nav view stack
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    let draggableYLower = UIScreen.screenHeight/1.575
    let draggableYUpper = UIScreen.screenHeight/24
    
    let leftLimit = UIScreen.screenWidth/15.575
    let rightLimit = UIScreen.screenWidth/1.075
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                
                if (value.location.y < draggableYLower && value.location.y > draggableYUpper){
                
                    self.location.y = value.location.y
                }
                
                if (value.location.x > leftLimit && value.location.x < rightLimit){
                
                    self.location.x = value.location.x
                }
                
                
            }
    }
        
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
                    
                    
                    /// Basic drag test
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.pink)
                        .frame(width: 100, height: 100)
                        .position(location)
                        .gesture(simpleDrag)
                    
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


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
