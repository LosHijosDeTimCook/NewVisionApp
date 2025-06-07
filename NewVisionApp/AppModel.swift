//
//  AppModel.swift
//  NewVisionApp
//
//  Created by SantiQ on 07/06/25.
//
// Rigo test Santi Test

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
}
