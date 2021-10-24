//
//  BackButtonView.swift
//  Swiftly
//
//  Created by Toby Moktar on 2021-10-15.
//

import SwiftUI

/// View 1: NavBarIcon
/// Description: View for the left navigation bar button
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

/// View 2: SpecialNavBarIcon
/// Description: Used mainly for the user account icon in chapters view
struct SpecialNavBarIcon: View {
    var text: String
    var body: some View {
        Image(systemName: text)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 44, height: 44)
            .foregroundColor(Color.white)
            .padding(.leading, 30)
    }
}
