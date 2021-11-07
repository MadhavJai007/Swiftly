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
                            chapterContentViewModel.willStartInteractiveSection = false
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
                                        
                                        /// Used to enable/disable questions based on their order
                                        Group{
                                            
                                            /// Chapter index
                                            let chapIndex = chaptersViewModel.selectedChapterIndex
                                            
                                            /// Getting index of question and the status of the question
                                            let index = chaptersViewModel.selectedChapter!.playgroundArr.firstIndex(of: question)
                                            
                                            let questionStatus = chapterContentViewModel.playgroundQuestionStatus[index!]
                                            
                                            /// If the status is incomplete
                                            if (questionStatus == "incomplete") {
                                                /// If it's the first question, enable it
                                                if (index == 0){
                                                    Button {
                                                        
                                                        chapterContentViewModel.selectedQuestionIndex = index!
                                                        chapterContentViewModel.setupPlayground(question: question, questionIndex: index!, userAnswers: chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].questionAnswers[index!].answers)
                                                    }label: {
                                                        InteractiveStartButton(text: "Start Playground", textColor: Color.white, backgroundColor: Color.darkGrayCustom)
                                                    }
                                                    .frame(width: geometry.size.width/1.50, height: 120)
                                                }else {
                                                    
                                                    /// Getting previous question status
                                                    let statusBefore = chapterContentViewModel.playgroundQuestionStatus[index!-1]
                                                    
                                                    /// If the previous question status is complete, enable current question
                                                    if (statusBefore == "complete"){
                                                        Button {
                                                            chapterContentViewModel.selectedQuestionIndex = index!
                                                            chapterContentViewModel.setupPlayground(question: question, questionIndex: index!, userAnswers: chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].questionAnswers[index!].answers)
                                                        }label: {
                                                            InteractiveStartButton(text: "Start Playground", textColor: Color.white, backgroundColor: Color.darkGrayCustom)
                                                        }
                                                        .frame(width: geometry.size.width/1.50, height: 120)
                                                    }
                                                    /// Otherwise, user doesn't have access to question so disable it
                                                    else{
                                                        
                                                        Button {
                                                            print("Tapped")
                                                        }label: {
                                                            InteractiveStartButton(text: "Start Playground", textColor: Color.white, backgroundColor: Color.darkGrayCustom)
                                                                .opacity(0.5)
                                                        }
                                                        .frame(width: geometry.size.width/1.50, height: 120)
                                                        .disabled(true)
                                                    }
                                                }
                                            }
                                            else{
                                                Button {
                                                    
                                                    chapterContentViewModel.selectedQuestionIndex = index!
                                                    chapterContentViewModel.setupPlayground(question: question, questionIndex: index!, userAnswers: chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].questionAnswers[index!].answers)
                                                }label: {
                                                    InteractiveStartButton(text: "Start Playground", textColor: Color.white, backgroundColor: Color.darkGrayCustom)
                                                }
                                                .frame(width: geometry.size.width/1.50, height: 120)
                                            }
                                            
                                        }
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
                        
                        Group{
                            
                            /// If it's not the last chapter in the classroom
                            if (chaptersViewModel.chaptersArr.firstIndex(of: chaptersViewModel.selectedChapter!) != chaptersViewModel.chaptersArr.count-1){
                                
                                /// Only showing next chapter button if user is finished playground questions
                                Group {
                                    
                                    if chapterContentViewModel.playgroundQuestionStatus.contains("incomplete"){
                                        Button{
                                            
                                        }label:{
                                            ButtonLabelLarge(text: "Next Chapter", textColor: .white, backgroundColor: .gray)
                                                .opacity(0.5)
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                        .padding(20)
                                        .disabled(true)
                                    }else{
                                        Button{
                                            
                                        
                                            chaptersViewModel.willStartNextChapter = true
                                            chapterContentViewModel.willStartInteractiveSection.toggle()
                                            chaptersViewModel.didStartChapter.toggle()
                                            
                                            
                                        }label:{
                                            ButtonLabelLarge(text: "Next Chapter", textColor: .white, backgroundColor: .green)
                                        }
                                        .frame(width: geometry.size.width, alignment: .center)
                                        .padding(20)
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
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
        
        .onAppear(){
            
            let chapIndex = chaptersViewModel.selectedChapterIndex
            
            let userTheoryProgress = chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].theoryStatus
            let userPlaygroundProgress = chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].playgroundStatus
            
            /// If user theory progress is inprogress
            if (userTheoryProgress == "inprogress"){
                
                /// Set theory progress to complete
                chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].theoryStatus = "complete"
            }
            
            /// If the user playground progress is incomplete
            if (userPlaygroundProgress == "incomplete"){
                
                /// Set playground status and classroom playground status to inprogress
                chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].playgroundStatus = "inprogress"
                chaptersViewModel.loggedInUser.classroom[0].classroomPlaygroundStatus = "inprogress"
            }
            
            
            chaptersViewModel.saveUserProgress()
            
            
            
            /// If all the questions in this playground are complete, set the chapter to be complete
//            if (chapterContentViewModel.playgroundQuestionStatus.contains("incomplete")){
//                print("Chapter incomplete")
//            }else{
//                chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].playgroundStatus = "complete"
//                chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].chapterStatus = "complete"
//                chaptersViewModel.loggedInUser.classroom[0].chapterProgress[chapIndex].theoryStatus = "complete"
//                
//                chaptersViewModel.chaptersStatus[chapIndex] = "complete"
//            }
        }
    }
}

/// Preview
struct InteractiveQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveQuestionsView()
    }
}
