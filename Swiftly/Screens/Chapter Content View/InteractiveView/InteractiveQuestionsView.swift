//  INFO49635 - CAPSTONE FALL 2021
//  InteractiveQuestionsView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct InteractiveQuestionsView: View {
    
    /// View responsive variables
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    /// View
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.blackCustom
                    .ignoresSafeArea()
                
                VStack{
                    HStack {
                        Button{
                            chapterContentViewModel.willStartInteractiveSection.toggle()
                        }label:{
                            NavBarIcon(iconName: "chevron.backward")
                        }
                        .padding(.leading, 30)
                        Spacer()
                    }
                    .padding(.top, geometry.size.width/16)
                    
                    TitleLabel(text: "Playgrounds")
                        .padding(.bottom, 75)
                    
                    TabView {
                    
                    /// ScrollView for playground questions
//                    ScrollView(.horizontal, showsIndicators: false) {
                        
                            ForEach(chaptersViewModel.selectedChapter!.playgroundArr) { question in
                                VStack{
                                    VStack(alignment: .leading){
                                        
                                        InteractiveSubTitlePreview(text: question.title)
                                            .padding(.leading, 20)
                                            .padding(.top, 20)
                                            .minimumScaleFactor(0.5)
                                        
                                        InteractiveContentTextPreview(text:question.description)
                                            .padding(.leading, 20)
                                            .padding(.trailing, 20)
                                            .minimumScaleFactor(0.5)
                                        
                                        Spacer()
                                        
                                        /// This is for the preview of interactive blocks
                                        HStack{
                                            Spacer()
                                            VStack{
                                                ForEach(0..<question.originalArr.count) { i in
                                                    VStack {
                                                        InteractiveBlockTextPreview(text: String(question.originalArr[i]))
                                                    }
                                                    .frame(width: UIScreen.screenWidth/2, height: 50, alignment: .leading)
                                                    .background(Color.darkGrayCustom)
                                                    .cornerRadius(7)
                                                }
                                            }
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                        
                                        /// This is for the start playground button
                                        VStack{
                                            Button {
                                                chapterContentViewModel.setupPlayground(question: question, questionIndex: chaptersViewModel.selectedChapter!.playgroundArr.firstIndex(of: question)!)
                                            }label: {
                                                InteractiveStartButton(text: "Start Playground", textColor: Color.white, backgroundColor: Color.darkGrayCustom)
                                            }
                                            .frame(width: geometry.size.width/1.50, height: 120)
                                        }
                                    }
                                    .frame(width: geometry.size.width/1.50, height: geometry.size.height/1.5)
                                    .background(Color.whiteCustom)
                                    .cornerRadius(40)
                                }
                                .frame(width: geometry.size.width/1.20, height: geometry.size.height/1.75)
                            }
                        
                    }
                    .frame(width: geometry.size.width/1.20, height: geometry.size.height/1.5)
                    .padding(.top, -60)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    /// HStack for next chapter button
                    HStack{
                        Button{
                            
                            /// If it's not the last chapter
                            if (chaptersViewModel.chaptersArr.firstIndex(of: chaptersViewModel.selectedChapter!) != chaptersViewModel.chaptersArr.count){
                                
                                chaptersViewModel.willStartNextChapter = true
                                chapterContentViewModel.willStartInteractiveSection.toggle()
                                chaptersViewModel.didStartChapter.toggle()
                            }
                            
                        }label:{
                            ButtonLabelLarge(text: "Next Chapter", textColor: .white, backgroundColor: .green)
                                .opacity(0.25)
                        }
                    }.frame(width: geometry.size.width, alignment: .center)
                        .padding(20)
                    
                    /// Navigation link for starting a playground question
                    NavigationLink(destination: InteractiveView()
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel),
                                   isActive: $chapterContentViewModel.willStartPlaygroundQuestion) {EmptyView()}
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

/// Preview
struct InteractiveQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveQuestionsView()
    }
}
