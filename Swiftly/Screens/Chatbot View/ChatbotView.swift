//  INFO49635 - CAPSTONE FALL 2021
//  ChatbotView.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

struct ChatbotView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(Color.blackCustom)
    }
    
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
                    .padding(.bottom, geometry.size.width/32)
                    
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
                        .padding(.bottom, -10)
                        
                        /// For the messages with chatbot
                        List {
                            
                            ForEach(chatbotViewModel.allMessages, id: \.id) { msg in
                                
                                /// If sender is user
                                if (msg.sender == Message.Sender.user){
                                    
                                    VStack{
                                        
                                        VStack{
                                            Text(msg.text)
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(Color.black)
                                                .padding(.leading, 5)
                                                .padding(.trailing, 5)
                                            
                                        }
                                        .frame(width: geometry.size.width/2, alignment: .leading)
                                        .padding(.top, 10)
                                        .padding(.bottom, 10)
                                        .background(Color.white)
                                        .cornerRadius(5)
                                    }
                                    .frame(width: geometry.size.width/1.10, alignment: .trailing)
                                    .listRowBackground(Color.clear)
                                    
                                    
                                /// If sender is the chatbot
                                }else if (msg.sender == Message.Sender.chatbot){
                                    VStack{
                                        
                                        VStack{
                                            Text(msg.text)
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(Color.black)
                                                .padding(.leading, 5)
                                                .padding(.trailing, 5)
                                            
                                        }
                                        .frame(width: geometry.size.width/2, alignment: .leading)
                                        .padding(.top, 10)
                                        .padding(.bottom, 10)
                                        .background(Color.white)
                                        .cornerRadius(5)
                                    }
                                    .frame(width: geometry.size.width/1.10, alignment: .leading)
                                    .listRowBackground(Color.clear)
                                }
                            }
                        }
                        .frame(width: geometry.size.width/1.10)
                        .cornerRadius(10)
                        
                        Spacer()
                        
                        HStack{
                            
                            TextField("Say something...", text: $userMessage)
                                .font(.system(size: 20, weight: .medium))
                                .frame(width: geometry.size.width/1.2, height: 50)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Button{
                                chatbotViewModel.send(text: userMessage)
                                userMessage = ""
                            }label:{
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.blackCustom)
                            }
                            .frame(width: 44, height: 44)
                        }
                        .frame(width: geometry.size.width/1.10)
                        .padding(.bottom, 15)
                        .padding(.top, 15)
                        
                        
                        
                    }.frame(width: geometry.size.width, alignment: .leading)
                    
                    
                    Spacer()
                }
            }
        }
        .onAppear(){
            chatbotViewModel.allMessages.removeAll()
            chatbotViewModel.chatlog.removeAll()
            SwiftlyApp.incomingChatbotMessages.removeAll()
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
