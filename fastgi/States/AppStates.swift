//
//  AppStates.swift
//  fastgi
//
//  Created by Hegaro on 21/07/2021.
//

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var moveToDashboard: Bool = false
} 
