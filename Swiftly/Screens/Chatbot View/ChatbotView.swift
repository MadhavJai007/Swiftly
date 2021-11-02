//  INFO49635 - CAPSTONE FALL 2021
//  ChatbotView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct ChatbotView: View {
    
    @EnvironmentObject var chatbotViewModel: ChatbotViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    @State var userMessage: String = ""
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                Color.whiteCustom
                    .ignoresSafeArea()
                
                
                VStack{
                    
                    HStack{
                        
                        Button{
                            chapterContentViewModel.isShowingChabot.toggle()
                        }label:{
                            ChatbotNavBarIcon(iconName: "xmark")
                            
                        }
                        .padding(.leading, 30)
                        
                        Spacer()
                        
                    }
                    .padding(.top, geometry.size.width/16)
                    .padding(.bottom, geometry.size.width/16)
                    
                    VStack{
                        
                        HStack{
                        
                            ChatbotTitleLabel(text: "Swiftly Assistant")
                                .padding(.leading, 30)
                        
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundColor(Color.blackCustom)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                            
                            Spacer()
                        }
                            
                        List {
                            ForEach(chatbotViewModel.allMessages, id: \.id) { msg in
                                
                                if (msg.sender == Message.Sender.user){
                                    
                                    ZStack{
                                        
                                        Color.blue
                                        
                                        Text(msg.text)
                                            .foregroundColor(Color.white)
                                    }
                                    .cornerRadius(3)
                                    .listRowBackground(Color.clear)
                                    
                                    
                                    
                                }else if (msg.sender == Message.Sender.chatbot){
                                    ZStack{
                                        
                                        Color.green
                                        
                                        Text(msg.text)
                                            .foregroundColor(Color.white)
                                    }
                                    .cornerRadius(3)
                                    .listRowBackground(Color.clear)
                                }
                                
                            }
                        }
                        
                        Spacer()
                        
                        HStack{
                            
                            TextField("Say something...", text: $userMessage)
                                .font(.system(size: 18))
                                .frame(width: geometry.size.width/1.3, height: 50)
                                .background(Color.white)
                                .foregroundColor(Color.blue)
                                .cornerRadius(15)
                            
                            Button{
                                chatbotViewModel.send(text: userMessage)
                                userMessage = ""
                            }label:{
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                
                            }
                            .frame(width: 44, height: 44)
                        }
                        .frame(width: geometry.size.width)
                        .padding(.bottom, 15)
                        
                        
                        
                    }.frame(width: geometry.size.width, alignment: .leading)
                    
                    
                    Spacer()
                }
            }
        }
    }
}

struct ChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        ChatbotView()
    }
}


struct ChatbotTitleLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 75, weight: .light))
            .foregroundColor(Color.blackCustom)
    }
}


struct ChatbotNavBarIcon: View {
    var iconName: String
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .foregroundColor(Color.blackCustom)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
    }
}
