//  INFO49635 - CAPSTONE FALL 2021
//  ChapterContentView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-01.

import SwiftUI

struct ChapterContentView: View {
    
    var chapter = MockData.sampleChapter
    
        @EnvironmentObject var chaptersViewModel: ChaptersViewModel
        @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel // view model for this view

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack {
                        
                        Button{
                            self.mode.wrappedValue.dismiss()
                        }label:{
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding(.leading, 30)
                        }
                        
                       
                        
                        Spacer()
                        
                        Image(systemName: "questionmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.white)
                            .padding(.trailing, 30)
                        
                        
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/16)
                    
                    TabView {
                        
                        // First page
                        VStack(alignment: .leading){
                            
                            ChaptersTitle(text: "Chapter: \(chapter.chapterNum)")
                                .padding(.leading, geometry.size.width/32)
                            
                            HStack{
                                Text(chapter.name)
                                    .font(.system(size: 40,
                                                  weight: .bold,
                                                  design: .default))
                                    .foregroundColor(Color.white)
                                
                                Image(systemName: "cpu")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, geometry.size.width/24)
                            .padding(.top, -geometry.size.width/24)
                            
                            
                            
                            VStack(alignment: .leading){
                                Text("Lorem Ipsum")
                                    .font(.system(size: 40,
                                                  weight: .bold,
                                                  design: .default))
                                    .foregroundColor(Color.white)
                                
                                ChapterSubTitleText(text:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla semper dapibus velit, ut volutpat lorem. Praesent sed interdum ligula.Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .padding(.top, -geometry.size.width/28)
                                    .padding(.trailing, geometry.size.width/24)
                                  
                            }
                            .padding(.top, geometry.size.width/12)
                            .padding(.leading, geometry.size.width/24)
                            
                            
                            Spacer()
                            
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                        
                        
                        
                        VStack{
                            Text("Page 2")
                        }
                        
                        
                        VStack{
                            Text("Page 3")
                        }
                        
                        
                    }
                    .tabViewStyle(.page)
                    
                }
                
            }
        }
        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView()
    }
}

