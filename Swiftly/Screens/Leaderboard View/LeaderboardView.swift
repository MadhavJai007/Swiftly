//  INFO49635 - CAPSTONE FALL 2021
//  LeaderboardView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct LeaderboardView: View {
    
    /// Environment variables
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel /// --> view model for this view
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 15){
                    
                    HStack {
                        Button{
                            chaptersViewModel.didSelectLeaderboard.toggle()
                        }label:{
                            NavBarIcon(iconName: "chevron.backward")
                        }
                        .padding(.leading, 30)
                        Spacer()
                    }
                    .padding(.top, geometry.size.width/16)
                    
                    HStack{
                        
                        TitleLabel(text:"Leaderboard")
                            .padding(.leading,  geometry.size.width/24)
                        ImageViewLarge(imageName: "chart.bar.xaxis")

                    }
                    
                    LeaderboardSubTitle(text: "Classroom: Global")
                        .padding(.leading,  geometry.size.width/24)
                    
                    HStack(spacing: 15){
                        
                        /// Todo: Uncomment code because it uses chapter passed to it from viewmodel. It's commented out for preview purposes.
                        //                        LeaderboardSubTitle(text:"Chapter:  \(leaderboardViewModel.selectedChapter.chapterNum)")
                        LeaderboardSubTitle(text:"Chapter:  1")
                        
                        Button{
                            print("tapped")
                        }label: {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(.leading,  geometry.size.width/24)
                    
                    VStack{
                        ZStack{
                            Color.whiteCustom
                            
                            VStack{
                                HStack(spacing: geometry.size.width/8){
                                    LeaderboardTableHeader(text: "Username")
                                    LeaderboardTableHeader(text: "Chapter Time")
                                    LeaderboardTableHeader(text: "Test Score")
                                }
                                .frame(width: geometry.size.width/1.10)
                                .padding(.top, 25)
                                Spacer()
                            }
                        }
                        .frame(width: geometry.size.width/1.10, height: geometry.size.height/1.35, alignment: .center)
                        .cornerRadius(40)
                    }
                    .frame(width: geometry.size.width)
                    .padding(.top, 15)
                }.frame(width: geometry.size.width, alignment: .leading)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

/// Preview
struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
