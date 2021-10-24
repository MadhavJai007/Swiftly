//  INFO49635 - CAPSTONE FALL 2021
//  Extensions.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import UIKit

/// Used to get the screen dimensions without geometry reader
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

/// Used to disable scroll for any view
extension View {
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UIScrollView.appearance().bounces = value
        }
    }
}
