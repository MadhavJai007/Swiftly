//
//  ChaptersViewModel.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-09-27.
//

import Foundation
import SwiftUI

final class ChaptersViewModel: ObservableObject {
    
    var didSelectChapter = false
    var didSelectLeaderboard = false
    
    @Published var isShowingDetailView = false
    
    var selectedChapter: Chapter? {
        didSet { isShowingDetailView = true }
    }
    
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())
    ]
    
}
