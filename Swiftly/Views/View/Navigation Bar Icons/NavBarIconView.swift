//
//  BackButtonView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-15.
//

import SwiftUI

/// View for the left navigation bar button
struct NavBarIcon: View {
    
    var iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .foregroundColor(.white)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
    }
}
