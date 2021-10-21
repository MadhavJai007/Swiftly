//  INFO49635 - CAPSTONE FALL 2021
//  InteractiveView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI
import UIKit
import UniformTypeIdentifiers

struct InteractiveView: View {
    
    @State var willUpdateView = false
    
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
                        
                        Button{
                            /// save progress
                        }label:{
                            NavBarIcon(iconName: "square.and.arrow.down")
                        }
                        .padding(.trailing, 30)
                        
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/32)
                    
                    HStack{
                        Spacer()
                        InteractiveSubTitle(text: chapterContentViewModel.selectedQuestion.title)
                        Spacer()
                    }
                    
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
                            .padding(.top, geometry.size.height/16)
                        }
                        .onDrop(of: [UTType.text], delegate: DropOutsideDelegate(current: $dragging))
                        .hasScrollEnabled(false)
                        
                        
                    }.frame(width: geometry.size.width/1.05, height: geometry.size.height/1.50, alignment: .center)
                        
                    
                    
                    Spacer()
                    
                    ZStack{
                        Color.darkGrayCustom
                            .ignoresSafeArea()
                        
                        HStack{
                            
                            
                            InteractiveContentText(text: chapterContentViewModel.selectedQuestion.description)
                                .padding(.leading, 15)
                                .padding(.bottom, 20)
                                .padding(.top, -10)
                                
                            Spacer()
                
                            VStack(alignment: .leading){
                                Button{
                                    
                                    if (chapterContentViewModel.isFinalChapter == false){
                                        chapterContentViewModel.startNextPlaygroundQuestion()
                                        willUpdateView.toggle()
                                    }else{
                                        /// Call function to end playground
                                        chapterContentViewModel.completeInteractiveSection()
                                    }
                                    
                                }label: {
                                    InteractiveSubTitle(text: chapterContentViewModel.chapterButtonText)
                                }
                                .frame(width: geometry.size.width/5, height: geometry.size.width/10)
                                .background(Color.blackCustom)
                                .cornerRadius(15)
                                .padding(.bottom, 20)
                                .padding(.trailing, 15)
                                .padding(.top, -10)
                                
                                
                            }.frame(width: geometry.size.width/4, alignment: .center)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/5)
                }
            }
        }
        .navigationBarHidden(true)
    
        .onDisappear {
            chapterContentViewModel.willStartNextQuestion = false
        }
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
            .font(.system(size: 35, weight: .medium))
            .foregroundColor(Color.white)
    }
}


struct InteractiveContentText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 25))
            .foregroundColor(Color.white)
            .minimumScaleFactor(0.5)
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
