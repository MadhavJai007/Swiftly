//  INFO49635 - CAPSTONE FALL 2021
//  ChapterScreen.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct ChaptersView: View {
    
    @State var isActive: Bool = false
    
    @EnvironmentObject var loginViewModel: LoginViewModel // view model for this view
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel /// view model for this view
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel
    
    /// Used to manually pop from nav view stack
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    HStack {
                        
                        Button{
                            chaptersViewModel.isShowingAccountView.toggle()
                        }label: {
                            UserAccountIcon(text: "person.crop.circle")
                        }
                        
                        Spacer()
                        
                        Button{
                            print(chaptersViewModel.chaptersArr)
                            print("tapped")
                            print("Logging into \(loginViewModel.accountMode) mode...")
                        }label: {
                            ClassroomInstanceView(text: "Join a class")
                        }
                    }.padding(.top, geometry.size.width/18)
                    
                    // All chapters label and classroom instance
                    VStack(alignment: .leading){
                        
                        ChaptersTitle(text:"All Chapters")
                            .padding(.leading, 30)
                        
                        Text("Classroom: Global")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding(.leading, 30)
                        
                    }.frame(width: geometry.size.width, alignment: .leading)
                    
                    Spacer()
                    
                    // ScrollView containing all chapters
                    ScrollView {
                        
                        LazyVGrid(columns: chaptersViewModel.columns, spacing: 50) {
                            ForEach(chaptersViewModel.chaptersArr) { chapter in
                                ChapterTitleView(chapter: chapter, width: geometry.size.width/2.35)
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                    .environmentObject(leaderboardViewModel)
                            }
                        }
                        .padding(30)
                        // Presenting chapter detail view
                        .sheet(isPresented: $chaptersViewModel.isShowingChapterDetailView) {
                            ChapterDetailView(isShowingDetailView: $chaptersViewModel.isShowingChapterDetailView)
                                .environmentObject(chaptersViewModel)
                                .environmentObject(chapterContentViewModel)
                        }
                    }
                    
                    // Nav link to accessing chapter content
                    NavigationLink(destination: ChapterContentView()
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                    .environmentObject(userAccountViewModel),
                                   isActive: $chaptersViewModel.didStartChapter) {EmptyView()}
                    
                    // Nav link to accessing user account
                    NavigationLink(destination: UserAccountView()
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(loginViewModel),
                                   isActive: $chaptersViewModel.isShowingAccountView) {EmptyView()}
                    
                    // Nav link to accessing user account
                    NavigationLink(destination: LeaderboardView()
                                    .environmentObject(userAccountViewModel)
                                    .environmentObject(leaderboardViewModel),
                                   isActive: $chaptersViewModel.didSelectLeaderboard) {EmptyView()}
                }
                Spacer()
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
            

        }
    }
}

struct ChaptersView_Preview: PreviewProvider {
    static var previews: some View {
        ChaptersView()
    }
}


// Struct representing the title label
struct ChaptersTitle: View {
    
    var text: String
    var body: some View {
        
        Text(text)
            .font(.system(size: 75,
                          weight: .medium, design: .default))
            .foregroundColor(.white)
    }
}

// Struct for the join/create a classroom view
struct ClassroomInstanceView: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 25))
            .fontWeight(.semibold)
            .padding()
            .frame(width: 250, height: 75)
            .background(Color.blackCustom)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.trailing, 30)
    }
}

// Struct representing user account icon
struct UserAccountIcon: View{
    
    var text: String
    
    var body: some View {
        Image(systemName: text)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
            .foregroundColor(Color.white)
            .padding(.leading, 30)
    }
}
