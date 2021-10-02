//  INFO49635 - CAPSTONE FALL 2021
//  ChapterContentView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-01.

import SwiftUI

struct ChapterContentView: View {
    
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel // view model for this view
    
    var body: some View {
        
        ZStack{
            
            Color.darkGrayCustom
                .ignoresSafeArea()
            
            TabView {
                Text("Page 1")
                Text("Page 2")
                Text("Page 3")
                
            }
            .tabViewStyle(.page)
        }
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView()
    }
}
