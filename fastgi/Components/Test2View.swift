//
//  Test2View.swift
//  fastgi
//
//  Created by Hegaro on 19/07/2021.
//


import SwiftUI
import UIKit
import Combine
struct Test2View: View {
   @ObservedObject var validationVM = ValidationViewModel()
   @ObservedObject var userDataVM = UserDataViewModel()
    @State var space: String = " "
    @State var name: String = ""
    
    
    init(){
        //self.userDataVM.DatosUser()
    }
    var body: some View {
        VStack{
            Text("NOMBRE")
                .textStyle(TitleStyle())
            TextField("Nombre", text: self.$validationVM.descriptions)
                .textFieldStyle(Input())
            
           /* self.name.forEach { (a) in
                print(a)
            }*/
              /*  .onChange(of: name) {
                   // print($0)
                    $0.forEach {
                      //  if $0 == "b"{
                            print($0)
                       // }
                    }
                }*/
            
        }
      /*  //EntryField(sfSymbolName: "envelope", placeHolder: "Ci", prompt: validationVM.ciPrompt, field: $validationVM.ci)
        /*EntryField(sfSymbolName: "envelope", placeHolder: "Nombre", prompt: validationVM.namePrompt, field: $validationVM.name)//.constant(self.userDataVM.user.nombres ?? ""))
        EntryField(sfSymbolName: "envelope", placeHolder: "Email Address", prompt: validationVM.emailPrompt, field: $validationVM.email)
        EntryField(sfSymbolName: "envelope", placeHolder: "Apellidos", prompt: validationVM.apellidosPrompt, field: $validationVM.apellidos)
        EntryField(sfSymbolName: "envelope", placeHolder: "Direccion", prompt: validationVM.direccionPrompt, field: $validationVM.direccion)
        EntryField(sfSymbolName: "envelope", placeHolder: "Nombre Nit", prompt: validationVM.nameNitPrompt, field: $validationVM.nombrenit)*/
        
        EntryField(sfSymbolName: "envelope", placeHolder: "Nombre", prompt: validationVM.nameCardPrompt, field: $validationVM.nameCard)//.constant(self.userDataVM.user.nombres ?? ""))
        EntryField(sfSymbolName: "envelope", placeHolder: "Numero", prompt: validationVM.cardNumberPrompt, field: $validationVM.cardNumber)
            .onChange(of: validationVM.cardNumber) {
                print($0)
                if $0.count == 4 || $0.count == 9 || $0.count == 14 {
                    self.validationVM.cardNumber = $0 + self.space
                }
            }
            .onReceive(Just(validationVM.cardNumber)) { value in
                      let shortString = String(value.prefix(19))
                      if shortString != value {
                          self.validationVM.cardNumber = shortString
                      }
            }
        EntryField(sfSymbolName: "envelope", placeHolder: "Fecha", prompt: validationVM.datePrompt, field: $validationVM.date)
            .onChange(of: validationVM.date) {
                print($0)
                if $0.count == 2  {
                    self.validationVM.date = $0 + self.space + "/" + self.space
                }
            }
            .onReceive(Just(validationVM.date)) { value in
                      let shortString = String(value.prefix(7))
                      if shortString != value {
                          self.validationVM.date = shortString
                      }
            }
        EntryField(sfSymbolName: "envelope", placeHolder: "Cvv", prompt: validationVM.cvvPrompt, field: $validationVM.cvv)
            .onChange(of: validationVM.cvv) {
                print($0)
                if $0.count == 3  {
                    print("llego limite")
                     //print("ya llego a 4")
                }
            }
            .onReceive(Just(validationVM.cvv)) { value in
                      let shortString = String(value.prefix(3))
                      if shortString != value {
                        self.validationVM.cvv = shortString
                      }
            }
       /* EntryField(sfSymbolName: "lock", placeHolder: "Password", prompt: validationVM.passwordPrompt, field: $validationVM.password, isSecure: true)
        EntryField(sfSymbolName: "lock", placeHolder: "Confirm", prompt: validationVM.confirmPwPrompt, field: $validationVM.confirmPw, isSecure: true)*/
        Button(action:{
            
        }){
            Text("Test")
        }
        .opacity(validationVM.isValidationComplete ? 1 : 0.6)
        .disabled(!validationVM.isValidationComplete)*/
    }
}

struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}

/*struct EntryField: View {
    var sfSymbolName: String
    var placeHolder: String
    var prompt: String
    @Binding var field: String
    var isSecure:Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName)
                    .foregroundColor(.gray)
                    .font(.headline)
                if isSecure {
                    SecureField(placeHolder, text: $field).autocapitalization(.none)
                } else {
                    
                    TextField(placeHolder, text: $field).autocapitalization(.none)
                }
            }
            .padding(8)
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}*/


