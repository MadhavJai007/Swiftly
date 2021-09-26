//
//  ChapterScreen.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-09-26.
//

import SwiftUI

struct ChaptersView: View {
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                Color.darkGrayCustom
                    .ignoresSafeArea()
                
                VStack{
                    
                    Image(systemName: "person.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        
                        
                    
                    
                    TitleLabel(text:"Chapters")
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
