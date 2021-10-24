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
struct SpinnerInfoLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color.whiteCustom)
            .font(.system(size: 20))
    }
}

/// Label 5: SpecialNavBarIcon
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

/// Label 6: ButtonLabelSmall
/// Description: Used throughout app for smaller button labels
struct ButtonLabelSmall: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 25))
            .fontWeight(.semibold)
            .padding()
            .frame(width: 250, height: 75)
            .background(Color.blackCustom)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.trailing, 30)
    }
}


/// Label 7: MultipleSelectionRow
/// Description: Used for the MCQ part of the playground section
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if self.isSelected {
                    Color.green
                        .opacity(0.60)
                }else{
                    Color.clear
                }
                
                VStack{
                    Button(action: self.action) {
                        Text(self.title)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .frame(width: UIScreen.screenWidth/1.25, height: 75, alignment: .leading)
                            .cornerRadius(15)
                    }
                }
            }.frame(width: UIScreen.screenWidth/1.25, height: 75, alignment: .leading)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2))
        }
    }
}

/// Label 8: InteractiveSubTitle
/// Description: Used in the interactive section
struct InteractiveSubTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 35, weight: .medium))
            .foregroundColor(Color.white)
    }
}


/// Label 9: InteractiveContentText
/// Description: Used in interactive section
struct InteractiveContentText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 25))
            .foregroundColor(Color.white)
            .minimumScaleFactor(0.5)
    }
}
