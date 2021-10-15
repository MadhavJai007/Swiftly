//  INFO49635 - CAPSTONE FALL 2021
//  InteractiveView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct InteractiveView: View {
    
    
    
    @State private var dragging: InteractiveBlock?
    
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel

    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.blackCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack {
                        Button{
                            chapterContentViewModel.willStartPlaygroundQuestion.toggle()
                        }label:{
                            NavBarIcon(iconName: "xmark")
                            
                        }
                        .padding(.leading, 30)
                        
                        Spacer()
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/32)
                    
                    /// For the tiles
                    VStack{
                        
                        ScrollView {
                            
                            LazyVGrid(columns: chapterContentViewModel.columns, spacing: 20) {
                                ForEach(chapterContentViewModel.activeBlocks) { block in

                                    /// Creating the tile view and passing the code block struct to it
                                    InteractiveTileView(codeBlock: block)
                                        .overlay(dragging?.id == block.id ? Color.white.opacity(0.8) : Color.clear)
                                        .cornerRadius(20)
                                        .onDrag {
                                            self.dragging = block
                                            return NSItemProvider(object: String(block.id) as NSString)
                                        }
                                        .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: block, listData: $chapterContentViewModel.activeBlocks, current: $dragging))
                                }
                            }
                            .animation(.default, value: chapterContentViewModel.activeBlocks)
                            .padding(.top, geometry.size.height/8)
                        }
                        .onDrop(of: [UTType.text], delegate: DropOutsideDelegate(current: $dragging))
                        .hasScrollEnabled(false)
                        
                        
                    }.frame(width: geometry.size.width/1.05, height: geometry.size.height/1.50, alignment: .center)
                        
                    
                    
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
                                    chapterContentViewModel.completeInteractiveSection()
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


/// Used to get the screen dimensions without geometry reader
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

/// Used to disable scroll for any view
extension View {
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UIScrollView.appearance().bounces = value
        }
    }
}
