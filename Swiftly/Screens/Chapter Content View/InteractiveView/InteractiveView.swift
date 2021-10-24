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
    
    
    init() {
        //        UITableView.appearance().separatorStyle = Color.white
        UITableView.appearance().separatorColor = UIColor(Color.clear)
        UITableView.appearance().isScrollEnabled = false
        UITableView.appearance().backgroundColor = .clear
    }
    
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
                            Text("Save")
                                .font(.system(size: 20, weight: .bold))
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
                    
                    /// For actual interactive section
                    VStack{
                        
                        Group {
                            
                            /// For code blocks method
                            if (chapterContentViewModel.selectedQuestion.type == "code_blocks"){
                                
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
                                        Spacer()
                                    }
                                    .animation(.default, value: chapterContentViewModel.activeBlocks)
                                    .padding(.top, geometry.size.height/16)
                                }
                                .onDrop(of: [UTType.text], delegate: DropOutsideDelegate(current: $dragging))
                                .hasScrollEnabled(false)
                                
                                /// For mcq method
                            }else{
                                Spacer()
                                
                                ForEach(chapterContentViewModel.mcqOptions, id: \.self) { item in
                                    MultipleSelectionRow(title: item, isSelected: chapterContentViewModel.mcqUserAnswers.contains(item)) {
                                        if chapterContentViewModel.mcqUserAnswers.contains(item) {
                                            chapterContentViewModel.mcqUserAnswers.removeAll(where: { $0 == item })
                                        }
                                        else {
                                            chapterContentViewModel.mcqUserAnswers.append(item)
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                }
                                .frame(width: UIScreen.screenWidth/1.25, height: 100, alignment: .leading)
                                
                                Spacer()
                                
                            }
                        }
                    }.frame(width: geometry.size.width/1.25, height: geometry.size.height/1.50, alignment: .center)
                    
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
                                    
                                    chapterContentViewModel.getQuestionScore()
                                    
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

