//
//  AuthState.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation

class AuthState: ObservableObject {
    @Published var navigateBack: Bool = false
    @Published var isAuth : Bool = false
    private let storage = UserDefaults.standard
    //navigation back two views
    @Published var moveToDashboard: Bool = false
    init() {
        self.validAuth()
    }
    
    private func validAuth(){
        if storage.string(forKey: "token") != nil{
            isAuth = true
        }
    }
}
