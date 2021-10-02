//  INFO49635 - CAPSTONE FALL 2021
//  ChapterScreen.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-26.

import SwiftUI

struct ChaptersView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var signupViewModel: SignupViewModel
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel // view model for this view
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color.white)
                            .padding(.leading, 30)
                        
                        Spacer()
                        
                        Button{
                            print("tapped")
                        }label: {
                            Text("Join a Classroom")
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
                    
                    VStack(alignment: .leading){
                        
                        ChaptersTitle(text:"All Chapters")
                            .padding(.leading, 30)
                        
                        Text("Classroom: Global")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding(.leading, 30)
                        
                    }.frame(width: geometry.size.width, alignment: .leading)
                    
                    Spacer()
                    
                    ScrollView {
                        LazyVGrid(columns: chaptersViewModel.columns, spacing: 50) {
                            ForEach(MockData.Chapters) { chapter in
                                ChapterTitleView(chapter: chapter, viewModel: chaptersViewModel)
                            }
                        }
                        .padding(30)
                        .sheet(isPresented: $chaptersViewModel.isShowingDetailView) {
                            
                            ChapterDetailView(isShowingDetailView: $chaptersViewModel.isShowingDetailView)
                                .environmentObject(chaptersViewModel)
                                .environmentObject(chapterContentViewModel)
                        }
                    }
                    
                    NavigationLink(destination: ChapterContentView()
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel)
                                   , isActive: $chaptersViewModel.didStartChapter) {EmptyView()}
                }
                Spacer()
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
                          weight: .semibold, design: .serif))
            .foregroundColor(.white)
    }
}
