//  INFO49635 - CAPSTONE FALL 2021
//  ChapterDetailView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

/// TODO: Chapter completion status has to come from the student collection not the chapter one.

struct ChapterDetailView: View {
    
    let chapter = MockData.sampleChapter
    
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel // view model for this view
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    // Connected to chaptersViewModel isShowingDetail
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
                    
                    HStack{
                        
                        ChaptersTitle(text: "Chapter \(chaptersViewModel.selectedChapter!.chapterNum)")
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
                                .frame(width: 25, height: 25)
                        }
                        .padding(.trailing, geometry.size.width/12)
                        .padding(.leading, -geometry.size.width/12)
                    }
                    
                    HStack{
                        
                        Text("\(chaptersViewModel.selectedChapter!.name)")
                            .font(.system(size: 35,
                                          weight: .bold,
                                          design: .default))
                            .foregroundColor(Color.white)
                        
                        Image(systemName: "\(chaptersViewModel.selectedChapter!.iconName)")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        
                    }
                    .padding(.trailing, -geometry.size.width/12)
                    .padding(.leading, geometry.size.width/12)
                    .padding(.top, -geometry.size.width/24)
                    
                    VStack(alignment: .leading){
                        
                        VStack(alignment: .leading, spacing: -geometry.size.width/48){
                            
                            ChapterContentText(text: "Estimated Length: \(chaptersViewModel.selectedChapter!.length) minutes")
                            
                            ChapterContentText(text:"Difficulty Level: \(chaptersViewModel.selectedChapter!.difficulty)")
                            
                            ChapterContentText(text:"Status: need to grab from student")
                            
                            ChapterContentText(text: chaptersViewModel.selectedChapter!.summary)
                                .padding(.trailing, geometry.size.width/6)
                                .padding(.top, geometry.size.width/24)
                        }
                        
                        Spacer()
                        
                        Button{
                            isShowingDetailView = false
                            chaptersViewModel.startChapterIntent = true
                            
                        }label: {
                            StartChapterButton(text: "Start Chapter", textColor: .white, backgroundColor: Color.blackCustom)
                        }
                        .padding(.leading, geometry.size.width/12)
                        .padding(.bottom, geometry.size.width/12)
                        
                        VStack(alignment: .leading){
                            
                            ChapterContentText(text: "Jump To")
                            
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
                                
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                        }
                        Spacer()
                    }
                    .padding(.trailing, -geometry.size.width/12)
                    .padding(.leading, geometry.size.width/12)
                }
                .padding(.top, geometry.size.width/12)
            }
        }
        
        .onDisappear {
            /// This is done so that the sheet can be dismissed before the chapter content view
            /// is presented.
            if (chaptersViewModel.startChapterIntent){
                
                /// Setting chapter data to chapterContentView
                chapterContentViewModel.chapter = chaptersViewModel.selectedChapter!
                chapterContentViewModel.setupPlaygroundQuestions(selectedChapter: chaptersViewModel.selectedChapter!)
                
                /// Resetting intentt and telling chaptersViewModel to start the chapter
                chaptersViewModel.startChapterIntent = false
                chaptersViewModel.startChapter()
            }
        }
    }
}


//struct ChapterDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChapterDetailView()
//    }
//}


/// Struct representing the label on a button
struct StartChapterButton: View {
    
    var text: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 40))
            .fontWeight(.medium)
            .padding()
            .frame(width: 500, height: 110)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(15)
    }
}


struct ChapterContentText: View {
    
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
