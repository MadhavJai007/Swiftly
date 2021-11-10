//  INFO49635 - CAPSTONE FALL 2021
//  ChapterScreen.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct ChaptersView: View {
    
    /// View responsive variables
    @State var isActive: Bool = false
    @State private var showPopup: Bool = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel /// --> view model for this view
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel
    @EnvironmentObject var chatbotViewModel: ChatbotViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    HStack {
                        Button {
                            /// Downloading user account data moved to .onAppear()
                            
                            /// Downloading user account information
                            if(!userAccountViewModel.isUserInfoRetrieved){
                                print("First time downloading user info")
                                userAccountViewModel.loadUserData(loggedInEmail: loginViewModel.loggedInEmail, accountType: loginViewModel.accountMode)
                            }
                            
                            chaptersViewModel.isShowingAccountView.toggle()
                        }label: {
                            SpecialNavBarIcon(text: "person.crop.circle")
                        }
                        
                        Spacer()
                        
//                        Button {
//                            showPopup.toggle()
//                            print(chaptersViewModel.chaptersArr)
//                            print("Logging into \(loginViewModel.accountMode) mode...")
//                        }label: {
//                            ButtonLabelSmall(text: "Join a class")
//                                .padding(.trailing, 30)
//                        }
                    }.padding(.top, geometry.size.width/18)
                    
                    VStack(alignment: .leading){
                        TitleLabel(text:"All Chapters")
                        
                        HStack{
                            
                            InfoLabelMedium(text:"Showing all available chapters")
                            
//                            Menu{
//                                ForEach(chaptersViewModel.loggedInUser.classroom){ classroom in
//                                    Button("Classroom: sdf", action: chaptersViewModel.changeClassroom)
//                                }
//                            }label: {
//                                Image(systemName: "chevron.down")
//                            }
                        }
                        .padding(.top, -35)
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                    .padding(.leading, 30)
                    
                    Spacer()
                    
                    /// ScrollView containing all chapters
                    ScrollView {
                        LazyVGrid(columns: chaptersViewModel.columns, spacing: 50) {
                            
                            ForEach(0..<chaptersViewModel.chaptersArr.count) { index in
                                
                                ChapterTitleView(chapter: chaptersViewModel.chaptersArr[index], width: geometry.size.width/2.35)
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                    .environmentObject(leaderboardViewModel)
                                
                            }
                        }
                        .sheet(isPresented: $chaptersViewModel.isShowingChapterDetailView) {
                            ChapterDetailView(isShowingDetailView: $chaptersViewModel.isShowingChapterDetailView)
                                .environmentObject(chaptersViewModel)
                                .environmentObject(chapterContentViewModel)
                        }
                    }
                    .padding(.trailing, 30)
                    
                    /// Nav link to accessing chapter content
                    NavigationLink(destination: ChapterContentView()
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(chatbotViewModel),
                                   isActive: $chaptersViewModel.didStartChapter) {EmptyView()}
                    
                    /// Nav link to accessing user account
                    NavigationLink(destination: UserAccountView()
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(loginViewModel),
                                   isActive: $chaptersViewModel.isShowingAccountView) {EmptyView()}
                    
                    /// Nav link to accessing user account
                    NavigationLink(destination: LeaderboardView()
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(leaderboardViewModel)
                                    .environmentObject(chaptersViewModel),
                                   isActive: $chaptersViewModel.didSelectLeaderboard) {EmptyView()}
                }
                Spacer()
                PopupUIView(title: "Join Classroom", message: "Join Classroom", buttonText: "Join", showPopup: $showPopup)
            }
        }
        .navigationBarHidden(true)
        
        .onAppear {
            print("onAppear 2")
            
            if (chaptersViewModel.logoutIntent == true){
                
                chaptersViewModel.logoutIntent = false
                chaptersViewModel.isUserLoggedIn = false
            }else{
                chaptersViewModel.saveUserProgress()
            }
            
            print(chaptersViewModel.loggedInUser.classroom[0].chapterProgress)
            
            /// Resetting  variables
            chaptersViewModel.isShowingAccountView = false
            chaptersViewModel.didStartChapter = false
            loginViewModel.attemptingLogin = false /// re-enables login button
            chaptersViewModel.jumpToPlayground = false
            
            
            if (chapterContentViewModel.willStartInteractiveSection == true){
                chapterContentViewModel.willStartInteractiveSection = false
            }
            
            /// If the user wants to start the next chapter
            if (chaptersViewModel.willStartNextChapter){
                
                chaptersViewModel.willStartNextChapter = false
                
                /// Get current chapter index and grab next chapter
                let chapIndex = chaptersViewModel.chaptersArr.firstIndex(of: chaptersViewModel.selectedChapter!)
                chaptersViewModel.selectedChapter = chaptersViewModel.chaptersArr[chapIndex!+1]
            }
            
        }
        
        .onDisappear {
            
//            if (chaptersViewModel.selectedChapter != nil && chaptersViewModel.didStartChapter == true){
//
//                chaptersViewModel.selectedChapterIndex = chaptersViewModel.chaptersArr.firstIndex(of: chaptersViewModel.selectedChapter!)!
//
//                print(chaptersViewModel.selectedChapterIndex)
//                print(chaptersViewModel.selectedChapter!.chapterNum)
//            }
            
            if (chaptersViewModel.isUserLoggedIn == false){
                
                
                loginViewModel.loggedInEmail = ""
                loginViewModel.accountMode = "Undefined"
                loginViewModel.isSuccessful = false
                loginViewModel.isLoading = false
                
                
            }    
        }
    }
}

/// Preview
struct ChaptersView_Preview: PreviewProvider {
    static var previews: some View {
        ChaptersView()
    }
}

//

