//
//  ChapterDetailView.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-28.
//

import SwiftUI

struct ChapterDetailView: View {
    
    var chapter: Chapter
    
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        Text("CHAPTER: \(chapter.chapterNum)")
    }
}

struct ChapterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterDetailView(chapter: MockData.sampleChapter, isShowingDetailView: .constant(false))
    }
}
