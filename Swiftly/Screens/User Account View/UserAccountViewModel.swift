//  INFO49635 - CAPSTONE FALL 2021
//  UserAccountViewModel.swift
//  Swiftly
//
//  Created by Toby moktar on 2021-10-03.

import Foundation
import SwiftUI

final class UserAccountViewModel: ObservableObject {

    ///Todo: User object needs to be passed down the view hierarch from the login viewmodel
    var user = MockData.sampleUser

}
