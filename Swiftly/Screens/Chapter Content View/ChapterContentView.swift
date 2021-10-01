//
//  ChapterContentView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-01.
//

import SwiftUI

struct ChapterContentView: View {
    var body: some View {
        TabView {
            Text("Page 1")
            Text("Page 2")
            Text("Page 3")
            
        }
        .tabViewStyle(.page)
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterContentView()
    }
}
