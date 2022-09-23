//  INFO49635 - CAPSTONE FALL 2021
//  ChapterScreen.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI
import GoogleMobileAds

struct ChaptersView: View {
    
    // View responsive variables
    @State var isActive: Bool = false
    @State private var showPopup: Bool = false
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel
    @EnvironmentObject var chatbotViewModel: ChatbotViewModel
    
    init(){
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                Color(UIColor.systemGray6)
                    .ignoresSafeArea()
                
                VStack{
                    HStack {
                        Button {
                            userAccountViewModel.clearStats()
                            userAccountViewModel.getUserStats()
                            chaptersViewModel.isShowingAccountView.toggle()
                        }label: {
                            SpecialNavBarIcon(text: "person.crop.circle")
                                .accessibilityLabel("View Account Button")
                        }
                        
                        Spacer()
                        
                    }.padding(.top, geometry.size.width/18)
                    
                    VStack(alignment: .leading){
                        
                        BannerAd(unitID:"ca-app-pub-3940256099942544/2934735716")
                        
                        TitleLabel(text:"All Chapters")
                            .accessibilityLabel("All Chapters")
                        
//                        Button {
//                            userAccountViewModel.clearStats()
//                            userAccountViewModel.getUserStats()
//                            chaptersViewModel.isShowingAccountView.toggle()
//                        }label: {
//                            SpecialNavBarIcon(text: "person.crop.circle")
//                                .accessibilityLabel("View Account Button")
//                        }
                        
                        Button {
                            chaptersViewModel.isShowingLeaderboardView.toggle()
                        }label: {
                            InfoLabelMedium(text: "View Leaderboard")
                                .foregroundColor(colorScheme == .dark ? Color.white: Color.black)
                                .accessibilityLabel("View Leaderboard")
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                    .padding(.leading, 30)
                    
                    /// Nav link to accessing chapter content
                    NavigationLink(destination: LeaderboardView()
                                    .environmentObject(leaderboardViewModel)
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(chaptersViewModel),
                                   isActive: $chaptersViewModel.isShowingLeaderboardView) {EmptyView()}
                    
                    Spacer()
                    
                    /// ScrollView containing all chapters
                    ScrollView {
                        LazyVGrid(columns: chaptersViewModel.columns, spacing: 50) {
                            
                            ForEach(0..<chaptersViewModel.chaptersArr.count) { index in
                                
                                ChapterTitleView(chapter: chaptersViewModel.chaptersArr[index], width: geometry.size.width/2.35)
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                    .environmentObject(leaderboardViewModel)
                                    .accessibilityLabel("Chapter \(chaptersViewModel.chaptersArr[index].chapterNum)")
                                
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
            
            userAccountViewModel.loggedInUser = chaptersViewModel.loggedInUser
            leaderboardViewModel.loggedInUser = chaptersViewModel.loggedInUser
            
            /// If the user is going to logout
            if (chaptersViewModel.logoutIntent == true){
                chaptersViewModel.logoutIntent = false
                chaptersViewModel.isUserLoggedIn = false
            }else{
//                chaptersViewModel.saveUserProgress()
                chaptersViewModel.retrieveUserbaseCompletion()
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

