//
//  ChapterDetailView.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-28.
//

import SwiftUI

struct ChapterDetailView: View {
    
    var chapter: Chapter
    
    @ObservedObject var viewModel = ChapterDetailViewModel()
    
    @Binding var isShowingDetailView: Bool
    
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            
            ZStack{
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                
                
                VStack(alignment: .leading){
                    
                    HStack{
                        
                        ChaptersTitle(text: "Chapter \(chapter.chapterNum)")
                            .padding(.trailing, -geometry.size.width/12)
                            .padding(.leading, geometry.size.width/12)
                        
                        Spacer()
                        
                        Button {
                            isShowingDetailView = false
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.white)
                                .imageScale(.large)
                                .frame(width: 20, height: 20)
                                
                                
                        }
                        .padding(.trailing, geometry.size.width/12)
                        .padding(.leading, -geometry.size.width/12)
                        
                        
                        
                        
                        
                    }
                    
                    HStack{
                        
                        Text(chapter.name)
                            .font(.system(size: 35,
                                          weight: .bold,
                                          design: .default))
                            .foregroundColor(Color.white)
                        
                        Image(systemName: "cpu")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        
                    }
                    .padding(.trailing, -geometry.size.width/12)
                    .padding(.leading, geometry.size.width/12)
                    .padding(.top, -geometry.size.width/24)
                    
                    
                    VStack(alignment: .leading){
                        
                        VStack(alignment: .leading, spacing: -geometry.size.width/48){
                        
                            ChapterSubTitleText(text: "Estimated Length: \(chapter.length) minutes")
                            
                            ChapterSubTitleText(text:"Difficulty Level: \(chapter.difficulty)")
                            
                            ChapterSubTitleText(text:"Status: Incomplete")
                            
                            ChapterSubTitleText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                .padding(.trailing, geometry.size.width/6)
                                .padding(.top, geometry.size.width/24)
                        }
                        
                        
                        VStack(alignment: .leading){
                            
                            ChapterSubTitleText(text: "Jump To")
                            
                            
                            HStack(spacing: geometry.size.width/32){
                                Button{
                                    print("tapped")
                                }label: {
                                    ChapterDetailsButtonText(text:"Notes")
                                    
                                }
                                .frame(width: 100, height: 50)
                                .background(Color.lightGrayCustom)
                                .cornerRadius(10)
                                
                                Button{
                                    print("tapped")
                                }label: {
                                    ChapterDetailsButtonText(text:"Interactive Section")
                                }
                                .frame(width: 260, height: 50)
                                .background(Color.lightGrayCustom)
                                .cornerRadius(10)
                                
                                Button{
                                    print("tapped")
                                }label: {
                                    ChapterDetailsButtonText(text:"Chapter Quiz")
                                }
                                .frame(width: 200, height: 50)
                                .background(Color.lightGrayCustom)
                                .cornerRadius(10)
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                        }
                    }
                    .padding(.trailing, -geometry.size.width/12)
                    .padding(.leading, geometry.size.width/12)
                    
                    
                    VStack{
                        Button{
                            print("tapped")
                        }label: {
                            StartChapterButton(text: "Start Chapter", textColor: .white, backgroundColor: Color.blackCustom)
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .center)
                    .padding(.top, geometry.size.width/12)
                        

                    NavigationLink(destination: ChapterContentView(), isActive: $viewModel.isSelected) {EmptyView()}
                    
                    Spacer()
                    
                }
                .padding(.top, geometry.size.width/12)
            }
            
            
        }
        
    }
}

struct ChapterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterDetailView(chapter: MockData.sampleChapter, isShowingDetailView: .constant(false))
    }
}



// Struct representing the label on a button
struct StartChapterButton: View {
    
    var text: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 35))
            .fontWeight(.semibold)
            .padding()
            .frame(width: 400, height: 75)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(15)
    }
}


struct ChapterSubTitleText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 30))
            .foregroundColor(Color.white)
            .padding(.top, 25)
    }
    
    
}


struct ChapterDetailsButtonText: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .font(.system(size: 30))
            .foregroundColor(Color.white)
        
    }
}
