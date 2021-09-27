//
//  ChapterTitleView.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-27.
//

import SwiftUI

struct ChapterTitleView: View {
    
    let chapter: Chapter
    
    var body: some View {
        
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
                
            }.frame(width: 350)
            
            Text("\(chapter.name)")
                .font(.system(size: 20, weight: .semibold))
                .padding(.leading, 10)
            
            Text("Estimated Length: \(chapter.estimatedLenght)")
                .font(.system(size: 20))
                .padding(.leading, 10)
            
            Text("Difficulty: \(chapter.difficulty)")
                .font(.system(size: 20))
                .padding(.leading, 10)
            
            HStack(){
                
                Spacer()
                
                Button{
                    print("Aa")
                }label: {
                    Text("View Leaderboard")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(Color.white)
                        .padding(7)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.trailing, -5)
                        .padding(.leading, 5)
                }.padding(.top, 20)
                
                

            }
            .frame(width: 350, height: 30, alignment: .center)
            
            
            
            
            
            Spacer()
            
            HStack{
                Text("Select Chapter")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(Color.white)
            }
            .frame(width: 350, height: 60)
            .cornerRadius(30)
            .background(Color.black)
            
            
        }.frame(width: 350, height:275, alignment: .leading)
            .background(Color.gray)
            .cornerRadius(30)
            
        
        

    }
}

struct ChapterTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterTitleView(chapter: MockData.sampleChapter)
    }
}
