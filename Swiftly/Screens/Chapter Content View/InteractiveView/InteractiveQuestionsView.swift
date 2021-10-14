//
//  InteractiveQuestionsView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-13.
//

import SwiftUI


struct InteractiveQuestionsView: View {
    
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.blackCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack {
                        Button{
                            chapterContentViewModel.willStartInteractiveSection.toggle()
                        }label:{
                            ChapterNavBarIcon(iconName: "chevron.backward")
                        }
                        .padding(.leading, 30)
                        
                        Spacer()
                        
                        
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/32)
                    
                    
                    PlaygroundTitleLabel(text: "Playgrounds")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHGrid(rows: [GridItem(.flexible())], spacing: 10){
                            
                            ForEach(chaptersViewModel.selectedChapter!.playgroundArr) { question in
                                
                        
                              
                                VStack{
                                    
                                    VStack(alignment: .leading){
                                        
                                        Text("\(question.title)")
                                            .font(.system(size: 35, weight: .medium))
                                            .padding(.leading, 20)
                                            .padding(.top, 20)
                                        
                                        Text("\(question.description)")
                                            .font(.system(size: 28))
                                            .padding(.leading, 20)
                                            .padding(.trailing, 20)
                                                                                
                                        Spacer()
                                        
                                        VStack{
                                            
                                            Button {
                                                chapterContentViewModel.setupPlayground(question: question)
                                            }label: {
                                                InteractiveStartButton(text: "Start Playground", textColor: Color.white, backgroundColor: Color.blackCustom)
                                            }
                                            .frame(width: geometry.size.width/1.50, height: 120)
                                        }
                                       
                                    }
                                    
                                    .frame(width: geometry.size.width/1.50, height: geometry.size.height/1.5)
                                    .background(Color.white)
                                    .cornerRadius(40)
                                }
                                .frame(width: geometry.size.width/1.20, height: geometry.size.height/1.5)
                                
                            }
                            
                        }
                        
                    }
                    .frame(width: geometry.size.width/1.20, height: geometry.size.height/1.5)
                    .padding(.top, -50)
                    
                    NavigationLink(destination: InteractiveView()
                                    .environmentObject(chaptersViewModel)
                                    .environmentObject(chapterContentViewModel),
                                   isActive: $chapterContentViewModel.willStartPlaygroundQuestion) {EmptyView()}
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct InteractiveQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveQuestionsView()
    }
}

// Struct representing the label on a button
struct InteractiveStartButton: View {
    
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

// Struct representing the title label
struct PlaygroundTitleLabel: View {
    
    var text: String
    var body: some View {
        
        Text(text)
            .font(.system(size: 75,
                          weight: .light))
            .foregroundColor(.white)
            .padding(.bottom, 75)
    }
}
