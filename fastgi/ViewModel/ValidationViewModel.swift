//
//  ValidationViewModel.swift
//  fastgi
//
//  Created by Hegaro on 19/07/2021.
//

import Foundation


class ValidationViewModel : ObservableObject {
    //var userDataVM = UserDataViewModel()
    let letras: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
                            "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                            "!","@","#","$","%","^","&","*","(",")","+","{","}","|",":"," ","<",">","?","-","=","[","]",";","'",",",".","/","_"]
    let letras1: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
                            "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                            "!","@","#","$","%","^","&","*","(",")","+","{","}","|",":","<",">","?","-","=","[","]",";","'",",",".","/","_"]
    let letras2: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
                            "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                            "!","@","#","$","%","^","&","*","(",")","+","{","}","|",":","<",">","?","-","=","[","]",";","'",",",".","_"]
    @Published var ci = ""
    @Published var email = ""
    @Published var name = ""
    @Published var apellidos = ""
    @Published var direccion = ""
    @Published var nombrenit = ""
    @Published var nit = ""
    //@Published var password = ""
    //@Published var confirmPw = ""
    //card
    @Published var nameCard = ""
    @Published var typeCobro = ""
    @Published var cardNumber = "" {
        didSet {
            for i in letras1 {
                if cardNumber.contains(i) {
                    cardNumber = oldValue
                }
            }
        }
    }
    @Published var date = "" {
        didSet {
            for i in letras2 {
                if date.contains(i) {
                    date = oldValue
                }
            }
        }
    }
    @Published var cvv = "" {
        didSet {
            for i in letras {
                if cvv.contains(i) {
                    cvv = oldValue
                }
            }
        }
    }
    @Published var cardtype = ""
    //login
    @Published var phoneNumber = "" {
        didSet {
            for i in letras {
                if phoneNumber.contains(i) {
                    phoneNumber = oldValue
                }
            }
        }
    }
    //sms
    @Published var pin = "" {
        didSet {
            for i in letras {
                if pin.contains(i) {
                    pin = oldValue
                }
            }
        }
    }
    @Published var phoneNumberArg = ""
  
    @Published var descriptions = ""  {
                didSet {
                    for i in letras {
                        if descriptions.contains(i) {
                            descriptions = oldValue
                        }
                    }
                }
            }
    
    /*init(){
        self.userDataVM.DatosUser1()
    }*/
   //card
    func isNameCardValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return nameTest.evaluate(with: nameCard )
    }
    func isCardNumberValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9 ]+$")
        return direccionTest.evaluate(with: cardNumber )
    }
    
    func isDateValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9 / ]+$")
        return direccionTest.evaluate(with: date )
    }
    
    func isCvvValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
        return direccionTest.evaluate(with: cvv )
    }
    //phonenumber
     func isPhoneNumberValid() -> Bool {
         //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
         return direccionTest.evaluate(with: phoneNumber )
     }
    func isPhoneNumberArgValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
       let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
        return direccionTest.evaluate(with: phoneNumberArg )
    }
    //pinsms
    //phonenumber
     func isPinValid() -> Bool {
         //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
         return direccionTest.evaluate(with: pin )
     }
    //test
    
    func isCiValid() -> Bool {
        let ciTest = NSPredicate(format: "SELF MATCHES %@", "/^\\d{5,10}([\\s-]\\d[A-Z])?$/")
        return ciTest.evaluate(with: ci )
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email )
    }
    
    func isNameValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return nameTest.evaluate(with: name )
    }
    
    func isApellidosValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let apellidosTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*$")
        return apellidosTest.evaluate(with: apellidos )
    }
    
    func isDireccionValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let direccionTest = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
        return direccionTest.evaluate(with: direccion )
    }
    
    func isNameNitValid() -> Bool {
        //self.name = self.userDataVM.user1.nombres
        let namenitTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9\\s.\\-]+$")
        return namenitTest.evaluate(with: nombrenit )
    }
    
  
    var isValidationComplete: Bool {
       // if  !isEmailValid() || !isNameValid() || !isApellidosValid() || !isDireccionValid() || !isNameNitValid() {
        if   !isNameCardValid() || !isCardNumberValid() || !isDateValid() || !isCvvValid() || self.cardtype == ""{
            return false
        }
        return true
    }
    var isValidationCompleteLogin: Bool {
            if   !isPhoneNumberValid() || self.phoneNumber.count != 8{
            return false
        }
        return true
    }
    var isValidationCompleteLoginArg: Bool {
            if   !isPhoneNumberArgValid() || self.phoneNumberArg.count != 11{
            return false
        }
        return true
    }
    var isValidationCompletePin: Bool {
            if   !isPinValid() || self.pin.count != 8{
            return false
        }
        return true
    }
    
    //card
    var nameCardPrompt : String {
        if isNameCardValid(){
            return ""
        }else {
            return "Ingrese banco valido"
        }
    }
    var cardNumberPrompt : String {
        if isCardNumberValid() && self.cardNumber.count == 19{
            return ""
        }else {
            return "Ingrese numero valido"
        }
    }
    var datePrompt : String {
        if isDateValid() && self.date.count == 7{
            return ""
        }else {
            return "Ingrese fecha valido"
        }
    }
    var cvvPrompt : String {
        if isCvvValid()  && self.cvv.count == 3{
            return ""
        }else {
            return "Ingrese cvv valido"
        }
    }
    //phone
    var phonePront : String {
        if isPhoneNumberValid() && self.phoneNumber.count == 8{
            return ""
        }else {
            return "Ingrese número valido"
        }
    }
    //
    //phone
    var pinPront : String {
        if isPinValid() && self.phoneNumber.count == 8{
            return ""
        }else {
            return "Ingrese pin valido"
        }
    }
    
    var phoneArgPront : String {
        if isPhoneNumberArgValid() && self.phoneNumberArg.count == 11{
            return ""
        }else {
            return "Ingrese número valido"
        }
    }
    var ciPrompt : String {
        if isCiValid(){
            return ""
        }else {
            return "Ingrese ci valido"
        }
    }
    
    var emailPrompt : String {
        if isEmailValid(){
            return ""
        }else {
            return "Ingrese email valido"
        }
    }
    
    var namePrompt : String {
        if isNameValid(){
            return ""
        }else {
            return "Ingrese nombre"
        }
    }
    
    var apellidosPrompt : String {
        if isApellidosValid(){
            return ""
        }else {
            return "Ingrese apellidos"
        }
    }
    
    var direccionPrompt : String {
        if isDireccionValid(){
            return ""
        }else {
            return "Ingrese direccion"
        }
    }
    
    var nameNitPrompt : String {
        if isNameNitValid(){
            return ""
        }else {
            return "Ingrese nombre del nit"
        }
    }
    
    
}
