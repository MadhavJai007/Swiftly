//  INFO49635 - CAPSTONE FALL 2021
//  ChapterContentView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-01.

import SwiftUI
import UIKit

/// TODO: Pass more view models down here (if needed to update student stats)
/// TODO: Might have to think of a better way to present theoretical data, because not every chapter will have exactly
/// three screens and so on. Might have to use a grid view where each cell is the size of the screen.

struct ChapterContentView: View {
        
    var chapter = MockData.sampleChapter

    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel /// view model for this view
    
    /// Used to manually pop from nav view stack
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack {
                        
                        Button{
                            chaptersViewModel.didStartChapter.toggle()
                        }label:{
                            ChapterNavBarIcon(iconName: "chevron.backward")
                        }
                        .padding(.leading, 30)
                        
                        Spacer()
                        
                        ChapterNavBarIcon(iconName: "questionmark")
                            .padding(.trailing, 30)
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/16)
                    
                    
                    /// ** Look at todo at top of file
                    TabView {
                        
                        /// Page 1
                        VStack(alignment: .leading){
                            
                            ChaptersTitle(text: "Chapter: \(chapterContentViewModel.chapter.chapterNum)")
                                .padding(.leading, geometry.size.width/32)
                            
                            HStack{
                                ChapterTopic(text: chapterContentViewModel.chapter.name)
                                ChapterTopicIcon(iconName: "cpu")
                            }
                            .padding(.leading, geometry.size.width/24)
                            .padding(.top, -geometry.size.width/30)
                            
                        
                            VStack(alignment: .leading){
                                ChapterSubTitle(text: "Data Types in Swift")
                                ChapterContentText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .padding(.top, -geometry.size.width/18)
                                    .padding(.trailing, geometry.size.width/24)
                                
                            }
                            .padding(.top, geometry.size.width/24)
                            .padding(.leading, geometry.size.width/24)
                            
                            VStack{
                                
                                Image("placeholder_img")
                                    .resizable()
                                    .scaledToFit()
                                
                            }.frame(width: geometry.size.width, alignment: .center)
                            
                            Spacer()
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                        
                        
                        /// Page 2
                        VStack(alignment: .leading){
                            
                            VStack(alignment: .leading){
                                ChapterSubTitle(text: "Lorem Ipsum")
                                ChapterContentText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .padding(.top, -geometry.size.width/18)
                                    .padding(.trailing, geometry.size.width/24)
                            }
                            .padding(.top, geometry.size.width/24)
                            .padding(.leading, geometry.size.width/24)
                            
                            VStack(alignment: .leading){
                                
                                ChapterSubTitle(text: "Lorem Ipsum")
                                ChapterContentText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .padding(.top, -geometry.size.width/18)
                                    .padding(.trailing, geometry.size.width/24)
                                
                            }
                            .padding(.top, geometry.size.width/24)
                            .padding(.leading, geometry.size.width/24)
                            
                        
                            Spacer()
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                        
                        /// PAGE 3
                        VStack(alignment: .leading){
                            
                            VStack(alignment: .leading){
                                ChapterSubTitle(text: "Lorem Ipsum")
                                ChapterContentText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .padding(.top, -geometry.size.width/18)
                                    .padding(.trailing, geometry.size.width/24)
                            }
                            .padding(.top, geometry.size.width/24)
                            .padding(.leading, geometry.size.width/24)
                            
                            VStack(alignment: .leading){
                                
                                ChapterSubTitle(text: "Lorem Ipsum")
                                ChapterContentText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .padding(.top, -geometry.size.width/18)
                                    .padding(.trailing, geometry.size.width/24)
                                
                            }
                            .padding(.top, geometry.size.width/24)
                            .padding(.leading, geometry.size.width/24)
                            
                            Spacer()
                            
                            HStack{
                                Spacer()
                                
                                Button{
                                    chapterContentViewModel.startInteractiveSection()
                                }label: {
                                    Text("Start Interactive Section")
                                        .font(.system(size: 30, weight: .semibold))
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: geometry.size.width/2, height: geometry.size.height/12)
                                .background(Color.blackCustom)
                                .cornerRadius(15)
                                
                                Spacer()
                            }
                            .padding(.bottom, geometry.size.width/100)
                            Spacer()
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                    }
                    .tabViewStyle(.page)
                }
            }
            
            NavigationLink(destination: InteractiveQuestionsView()
                            .environmentObject(chaptersViewModel)
                            .environmentObject(chapterContentViewModel),
                           isActive: $chapterContentViewModel.willStartInteractiveSection) {EmptyView()}
        }
        .navigationBarHidden(true)
        
//        .onAppear(){
//
//            /// Loading chapter  playground into the chapterContentViewModel
//            if (chapterContentViewModel.chapter != chaptersViewModel.selectedChapter!){
//                chapterContentViewModel.setupPlaygroundQuestions(selectedChapter: chaptersViewModel.selectedChapter!)
//            }
//        }
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView()
    }
}

/// struct representing chapter topic
struct ChapterTopic: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 40,
                          weight: .bold,
                          design: .default))
            .foregroundColor(Color.white)
    }
}


/// struct representing chapter icon
struct ChapterTopicIcon: View {
    
    var iconName: String
    
    var body: some View {
        
        Image(systemName: iconName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
        
    }
}

struct ChapterNavBarIcon: View {
    
    var iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .foregroundColor(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
    }
}

struct ChapterSubTitle: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 40,
                          weight: .bold,
                          design: .default))
            .foregroundColor(Color.white)
    }
}
