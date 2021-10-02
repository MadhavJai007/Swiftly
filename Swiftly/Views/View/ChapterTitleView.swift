//  INFO49635 - CAPSTONE FALL 2021
//  ChapterTitleView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-27.

import SwiftUI

struct ChapterTitleView: View {
    
    let chapter: Chapter
    
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel // view model for this view
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel

    var body: some View {
        
        VStack{
            
            VStack(alignment: .leading, spacing: 5){
                
                HStack{
                    Text("Chapter \(chapter.chapterNum)")
                        .font(.system(size: 35))
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(10)
                        .foregroundColor(Color.lightGrayCustom)
                    
                }.frame(width: 325)
                
                ChapterInfoLabel(text: "\(chapter.name)")
                ChapterInfoLabel(text: "Estimated Length: \(chapter.length)")
                ChapterInfoLabel(text: "Difficulty: \(chapter.difficulty)")
                
                HStack(){
                    
                    Spacer()
                    
                    Button{
                        print("Tapped")
                    }label: {
                        ViewLeaderboardButtonLabel(text: "View Leaderboard")
                    }.padding(.top, 20)
                    
                }
                .frame(width: 325, height: 30, alignment: .center)
                
                Spacer()
                
                HStack{
                    Button{
                        chaptersViewModel.selectedChapter = chapter
                    } label: {
                        Text("Select Chapter")
                            .font(.system(size: 20,
                                          weight: .semibold,
                                          design: .default))
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: 325, height: 60)
                .cornerRadius(30)
                .background(Color.lightGrayCustom)
                
            }.frame(width: 325, height:275, alignment: .leading)
                .background(Color.whiteCustom)
                .cornerRadius(15)
        }
    }
}


struct ChapterTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterTitleView(chapter: MockData.sampleChapter)
    }
}



struct ViewLeaderboardButtonLabel: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .foregroundColor(Color.white)
            .padding(7)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .background(Color.leaderboardBtnBackground)
            .cornerRadius(10)
            .padding(.trailing, -5)
            .padding(.leading, 5)
    }
}


struct ChapterInfoLabel: View{
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .semibold))
            .padding(.leading, 10)
    }
    
}
