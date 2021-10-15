//  INFO49635 - CAPSTONE FALL 2021
//  LeaderboardView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct LeaderboardView: View {
    
    @EnvironmentObject var leaderboardViewModel: LeaderboardViewModel // view model for this view
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                
                VStack(alignment: .leading, spacing: 15){
                    
                    HStack{
                        
                        LeaderboardTitle(text:"Leaderboard")
                            .padding(.leading,  geometry.size.width/24)
                        
                        
                        Image(systemName: "chart.bar.xaxis")
                            .resizable()
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 65, height: 65)
                        
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
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}


// Struct representing the title label
struct LeaderboardTitle: View {
    
    var text: String
    var body: some View {
        
        Text(text)
            .font(.system(size: 75,
                          weight: .medium, design: .default))
            .foregroundColor(.white)
    }
}


struct LeaderboardSubTitle: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 30))
            .foregroundColor(Color.white)
    }
    
    
}

struct LeaderboardTableHeader: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 30, weight: .semibold))
            .foregroundColor(Color.blackCustom)
    }
    
    
}
