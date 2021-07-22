//
//  ContentView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthState
    @State var isView1Active: Bool = false
    
    @State private  var cardNumber = ""
    @State private  var idCard = ""
    var body: some View {
        NavigationView {
            VStack {
                Text("Content View")
                    .font(.headline)
                
                NavigationLink(destination: View1(), isActive: $isView1Active) {
                    Text("View 1")
                        .font(.headline)
                }
                .isDetailLink(false)
            }
            .onReceive(self.authState.$moveToDashboard) { moveToDashboard in
                if moveToDashboard {
                    print("Move to dashboard: \(moveToDashboard)")
                    self.isView1Active = false
                    self.authState.moveToDashboard = false
                }
            }
        }
    }
}

struct View1: View {
    
    var body: some View {
        VStack {
            Text("View 1")
                .font(.headline)
            NavigationLink(destination: View2()) {
                Text("View 2")
                    .font(.headline)
            }
        }
    }
}

// MARK:- View 2
struct View2: View {
    @EnvironmentObject var authState:AuthState
    
    var body: some View {
        VStack {
            Text("View 2")
                .font(.headline)
            Button(action: {
                self.authState.moveToDashboard = true
            }) {
                Text("Move to Dashboard")
                .font(.headline)
            }
        }
    }
}

