//
//  ChapterQuizView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-12.
//

import SwiftUI

struct ChapterQuizView: View {
    
    /// Used to manually pop from nav view stack
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var chaptersViewModel: ChaptersViewModel
    @EnvironmentObject var chapterContentViewModel: ChapterContentViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ChapterQuizView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterQuizView()
    }
}
