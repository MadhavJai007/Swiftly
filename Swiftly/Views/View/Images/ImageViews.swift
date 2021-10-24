//
//  ImageViews.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-24.
//

import Foundation
import SwiftUI

struct ImageViewLarge: View {
    
    var imageName: String
    var body: some View {
        
        Image(systemName: imageName)
            .resizable()
            .foregroundColor(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 55, height: 55)
    }
}
