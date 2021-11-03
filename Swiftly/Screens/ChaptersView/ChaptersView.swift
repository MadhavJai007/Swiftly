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
                            /// Loading data
                            print(userAccountViewModel.loggedInUser)
                            if(!userAccountViewModel.isUserInfoRetrieved){
                                print("First time downloading user info")
                                userAccountViewModel.loadUserData(loggedInEmail: loginViewModel.loggedInEmail, accountType: loginViewModel.accountMode)
                            }
                            chaptersViewModel.isShowingAccountView.toggle()
                        }label: {
                            SpecialNavBarIcon(text: "person.crop.circle")
                        }
                        
                        Spacer()
                        
                        Button {
                            showPopup.toggle()
                            print(chaptersViewModel.chaptersArr)
                            print("Logging into \(loginViewModel.accountMode) mode...")
                        }label: {
                            ButtonLabelSmall(text: "Join a class")
                                .padding(.trailing, 30)
                        }
                    }.padding(.top, geometry.size.width/18)
                    
                    VStack(alignment: .leading){
                        TitleLabel(text:"All Chapters")
                        InfoLabelMedium(text:"Classroom: Global")
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                    .padding(.leading, 30)
                    
                    Spacer()
                    
                    /// ScrollView containing all chapters
                    ScrollView {
                        LazyVGrid(columns: chaptersViewModel.columns, spacing: 50) {
                            ForEach(chaptersViewModel.chaptersArr) { chapter in
                                ChapterTitleView(chapter: chapter, width: geometry.size.width/2.35)
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
            chaptersViewModel.isShowingAccountView = false
            chaptersViewModel.didStartChapter = false
            loginViewModel.attemptingLogin = false /// re-enables login button
            
            if (chapterContentViewModel.willStartInteractiveSection == true){
                chapterContentViewModel.willStartInteractiveSection = false
            }
            
            
            if (chaptersViewModel.willStartNextChapter){
                
                chaptersViewModel.willStartNextChapter = false
                
                var chapIndex = chaptersViewModel.chaptersArr.firstIndex(of: chaptersViewModel.selectedChapter!)
                
                chaptersViewModel.selectedChapter = chaptersViewModel.chaptersArr[chapIndex!+1]
                
                
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
