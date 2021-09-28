//
//  ChapterScreen.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-26.
//

import SwiftUI

struct ChaptersView: View {
    
    @ObservedObject var viewModel = ChaptersViewModel()
    
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
                            print("as")
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
                        LazyVGrid(columns: viewModel.columns, spacing: 50) {
                            ForEach(MockData.Chapters) { chapter in
                                ChapterTitleView(chapter: chapter, viewModel: viewModel)
                            }
                        }
                        .padding(30)
                        .sheet(isPresented: $viewModel.isShowingDetailView) {
                            ChapterDetailView(chapter: viewModel.selectedChapter!, isShowingDetailView: $viewModel.isShowingDetailView)
                        }
                            
                    }
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
