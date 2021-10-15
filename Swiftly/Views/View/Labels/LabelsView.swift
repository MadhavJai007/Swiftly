//  INFO49635 - CAPSTONE FALL 2021
//  Labels.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import SwiftUI

/// Label 1: TitleLabel
/// Description: Largest label in app, used for things like main titles.
struct TitleLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 75, weight: .medium))
            .foregroundColor(.white)
    }
}

/// Label 2: ButtonLabelLarge
/// Description: Largest button label, used for sign up button, login button, etc.
struct ButtonLabelLarge: View {
    var text: String
    var textColor: Color
    var backgroundColor: Color
    var body: some View {
        Text(text)
            .font(.system(size: 35, weight: .semibold))
            .padding()
            .frame(width: 400, height: 75)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(15)
    }
}

/// Label 3: InfoLabelMedium
/// Description: Used for displaying medium-sized labels
struct InfoLabelMedium: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 25, weight: .light))
            .foregroundColor(.white)
    }
}

/// Label 4: SpinnerInfoLabel
/// Description: Used for representing text in a progress (spinner) view
struct SpinnerInfoLabel: View{
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color.whiteCustom)
            .font(.system(size: 20))
    }
}
