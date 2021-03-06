//
//  LoginViewModel.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import Foundation
import Alamofire
import Combine
import SwiftUI
import ValidatedPropertyKit

class LoginViewModel: ObservableObject {
    //validation
    @Published private(set) var brokenRules = [BrokenRule]()
    @Validated(.required(errorMessage:"por favor ingrese su num") && .range(8...8))
    var telefono:String? = ""
    
    //
    @Published var authenticated = 0
    @Published var ruta: String? = ""
    @Published var messageError: String = ""
    @Published var isloading: Bool = false
    @Published var statusResponce = false
    //sms porel momento
    //@Published var pin = Usuario(role: "", estado: true, _id: "", telefono: "", pin: "", fecha: "")
    var loginResponse=Login()
    
    private var disposables: Set<AnyCancellable> = []
    //sms
    @Published var smstext: String = ""
    
    private var testvariable: AnyPublisher<String, Never> {
        loginResponse.$ruta
            .receive(on: RunLoop.main)
            .map { response in
                guard let response = response else {
                    return ""
                }
                return response
        }
        .eraseToAnyPublisher()
    }
    
    private var ErrorPublished: AnyPublisher<String, Never> {
        loginResponse.$messageError
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    private var isLoadingPublished: AnyPublisher<Bool, Never> {
        loginResponse.$isloading
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    //DataUser
    /*private var dataPinPublished: AnyPublisher<Usuario, Never> {
        loginResponse.$pin
              .receive(on: RunLoop.main)
              .map { response in
                  guard let response = response else {
                    return self.pin
                  }
                  return response
              }
              .eraseToAnyPublisher()
      }*/
    
    private var smsTextPublished: AnyPublisher<String, Never> {
        loginResponse.$smstext
            .receive(on: RunLoop.main)
            .map { response in
                return response
        }
        .eraseToAnyPublisher()
    }
    
    init(){
        testvariable
            .receive(on: RunLoop.main)
            .assign(to: \.ruta!, on: self)
            .store(in: &disposables)
        //loginResponse.me()
        
        ErrorPublished
            .receive(on: RunLoop.main)
            .assign(to: \.messageError, on: self)
            .store(in: &disposables)
        
        isLoadingPublished
            .receive(on: RunLoop.main)
            .assign(to: \.isloading, on: self)
            .store(in: &disposables)
        
       /* dataPinPublished
            .receive(on: RunLoop.main)
            .assign(to: \.pin, on: self)
            .store(in: &disposables)
        */
        smsTextPublished
            .receive(on: RunLoop.main)
            .assign(to: \.smstext, on: self)
            .store(in: &disposables)
        
    }
    
    func loginSms(telefono:String) {
        loginResponse.loginDetail(telefono: telefono)
    }
    
    func verificarCode(telefono:String,code:String) {
        loginResponse.confirmCode(telefono: telefono, pin: code)
    }
    
    //validation
    func validationInput()  {
        if self.validate() {
            
        }
    }
    
    private func validate() -> Bool {
        self.brokenRules.removeAll()
        
        let rules = [
        "Telefono name": _telefono.validationError,
        ]
        
        _ = rules.compactMap{ pair in
            guard let errormessage = pair.1?.failureReason else {
                return
            }
            self.brokenRules.append(BrokenRule(propertyName: pair.0, message: "\(errormessage)"))
        }
        return self.brokenRules.count == 0
    }
    
}
