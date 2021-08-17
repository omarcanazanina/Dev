//
//  LoginView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import UIKit
import Introspect

struct LoginView: View {
    @ObservedObject var loginVM = LoginViewModel()
    //validar campo
    @ObservedObject var validationVM = ValidationViewModel()
    @State var showingSheet = false
    @State var code: String = "+591"
    @State var phone: String = ""
    @State var country: String = "Bolivia"
    
    @ObservedObject var login = Login()
    @State var telefono: String = ""
    
    var image = UIImage()
    //clogin con correo
    @State private var action:Int? = 0
   
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        NavigationView{
            VStack(spacing:10) {
               
                Text("Fastgi")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top)
                //Text("este es el sms \(self.loginVM.smstext)")
                //Text("este es el sms \(self.loginVM.pin.pin)")
                Text("Te enviaremos un sms con el código de verificación")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.bottom)
                
                /*Button select codes*/
                Button(action: {
                    self.showingSheet.toggle()
                }) {
                    HStack{
                        
                        Text(self.country)
                            .foregroundColor(.white)
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }.sheet(isPresented: $showingSheet) {
                    ListAreaCodeView(
                        showingSheet: self.$showingSheet,
                        code: self.$code,
                        country: self.$country)
                }
                HStack{
                    VStack{
                        TextField("Código", text: $code)
                            .padding(14)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .keyboardType(.namePhonePad)
                            .frame(maxWidth:120)
                            .clipShape(Capsule())
                            .disabled(true)
                        VStack{
                            Text(" ")
                        }
                    }
                    if self.code == "+591" {
                        VStack (alignment: .leading){
                            //TextField("Teléfono", text: self.$loginVM.telefono.bound)
                           EntryField1(placeHolder: "Teléfono", field: $validationVM.phoneNumber)
                                .keyboardType(.numberPad)
                                .padding(20)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                               .frame(width:220)
                                .introspectTextField { (textField) in
                                    textField.becomeFirstResponder()
                                 }
                            VStack {
                                PromptFile(prompt: validationVM.phonePront)
                            }
                        }
                      
                      
                    }else {
                        VStack (alignment: .leading){
                            // TextField("Teléfono", text: self.$loginVM.telefono.bound)
                             EntryField1(placeHolder: "Teléfono Arg", field: $validationVM.phoneNumberArg)
                                 .keyboardType(.numberPad)
                                 .padding(20)
                                 .background(Color.white)
                                 .foregroundColor(.black)
                                 .clipShape(Capsule())
                                 .frame(width:220)
                                 .introspectTextField { (textField) in
                                     textField.becomeFirstResponder()
                                  }
                            VStack {
                                PromptFile(prompt: validationVM.phoneArgPront)
                            }
                        }
                    }
                }
          
                
                //BrokenRulesView(brokenRules: self.loginVM.brokenRules)
                /*Button(action: {
                    self.loginVM.validationInput()
                    //self.login.loginDetail(telefono: self.loginVM.telefono.bound)
                    self.loginVM.loginSms(telefono: self.loginVM.telefono.bound)
                })
                {
                    Text("Ingresar")
                        .textStyle(TextButtonLoginStyle())
                }*/
           
                Button(action: {
                    self.action = 1
                }){
                    Text("logueo por user y password")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                
                if self.code == "+591" {
                    Button(action:{
                        self.loginVM.loginSms(telefono: self.validationVM.phoneNumber)
                    }){
                        Text("Ingresar")
                            .textStyle(TextButtonLoginStyle())
                    }
                    .opacity(validationVM.isValidationCompleteLogin ? 1 : 0.6)
                    .disabled(!validationVM.isValidationCompleteLogin)
                    Spacer()
                }else{
                    Button(action:{
                    
                    }){
                        Text("Ingresar")
                            .textStyle(TextButtonLoginStyle())
                    }
                    .opacity(validationVM.isValidationCompleteLoginArg ? 1 : 0.6)
                    .disabled(!validationVM.isValidationCompleteLoginArg)
                    Spacer()
                }
             
                //Spacer()
                //este funciona
                NavigationLink(destination: LoginUserPasswordView(), tag: 1, selection: self.$action) {
                   EmptyView()
                }
              /*  NavigationLink(destination: CodeView(number: "12121212", smstext: self.loginVM.smstext), tag: "idlogin", selection: self.$login.ruta) {
                    EmptyView()
                }*/
            }
        
            .padding([.top, .leading, .trailing])
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(Color("primary"))
            .edgesIgnoringSafeArea(.top)
        }
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct EntryField1: View {
    var placeHolder: String
    @Binding var field: String
    var isSecure:Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                if isSecure {
                    SecureField(placeHolder, text: $field).autocapitalization(.none)
                } else {
                    TextField(placeHolder, text: $field).autocapitalization(.none)
                }
            }
        }.frame(height:11)
    }
}

struct PromptFile: View {
    var prompt: String
    var body: some View {
        VStack {
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}
