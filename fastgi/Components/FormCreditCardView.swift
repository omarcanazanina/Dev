//
//  FormCreditCardView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
import Combine
struct FormCreditCardView: View {
    
    @State var card_nombre: String = ""
    @State var card_number: String = ""
    @State var card_expiry_date: String = ""
    @State var card_cvn: String = ""
    @State var card_type: String = ""
    @State var showingSheetCity = false
    @State var showingSheetCard = false
    @State var city: String = "Seleccionar ciudad"
    @State var card: String = "Seleccionar card"
    @State var space: String = " "
    //testcard
    @State var test: String = "0123456789"
    @ObservedObject var cards = Cards()
    @ObservedObject var cardsVM = CardsViewModel()
    @ObservedObject var validationVM = ValidationViewModel()
    @State var alertState: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> 
   //button radio
    //@State var selectedId: String = ""
    var pickerCity: some View{
        Button(action: {
            self.showingSheetCity.toggle()
        }) {
            HStack{
                Text(self.city)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetCity) {
            ListCityView(
                showingSheet: self.$showingSheetCity,
                city: self.$city)
        }
    }
    
    var pickerCard: some View{
        Button(action: {
            self.showingSheetCard.toggle()
        }) {
            HStack{
                Text(self.card)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingSheetCard) {
            ListCardsView(
                showingSheet: self.$showingSheetCard,
                card: self.$card)
        }
    }
    
    var body: some View {
        VStack{
            ScrollView(){
                VStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text("BANCO")
                            .textStyle(TitleStyle())
                        EntryField( placeHolder: "Nombre Banco", prompt: validationVM.nameCardPrompt, field: $validationVM.nameCard)
                        Text("NUMERO")
                            .textStyle(TitleStyle())
                        EntryField( placeHolder: "Número", prompt: validationVM.cardNumberPrompt, field: $validationVM.cardNumber)
                            .keyboardType(.numberPad)
                            .introspectTextField { (textField) in
                                let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                             doneButton.tintColor = .darkGray
                                toolBar.items = [flexButton, doneButton]
                                toolBar.setItems([flexButton, doneButton], animated: true)
                                textField.inputAccessoryView = toolBar
                             }
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
                        HStack{
                            VStack(alignment: .leading){
                                Text("MES / AÑO")
                                    .textStyle(TitleStyle())
                                EntryField(placeHolder: "mes / año", prompt: validationVM.datePrompt, field: $validationVM.date)
                                    .keyboardType(.numberPad)
                                    .introspectTextField { (textField) in
                                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                        let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                     doneButton.tintColor = .darkGray
                                        toolBar.items = [flexButton, doneButton]
                                        toolBar.setItems([flexButton, doneButton], animated: true)
                                        textField.inputAccessoryView = toolBar
                                     }
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
                            }
                            VStack(alignment: .leading){
                                Text("CVV")
                                    .textStyle(TitleStyle())
                                EntryField(placeHolder: "Cvv", prompt: validationVM.cvvPrompt, field: $validationVM.cvv)
                                    .keyboardType(.numberPad)
                                    .introspectTextField { (textField) in
                                        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 44))
                                        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
                                        let doneButton = UIBarButtonItem(title: "Cerrar", style: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))
                                     doneButton.tintColor = .darkGray
                                        toolBar.items = [flexButton, doneButton]
                                        toolBar.setItems([flexButton, doneButton], animated: true)
                                        textField.inputAccessoryView = toolBar
                                     }
                                    .onReceive(Just(validationVM.cvv)) { value in
                                        let shortString = String(value.prefix(3))
                                        if shortString != value {
                                            self.validationVM.cvv = shortString
                                        }
                                    }
                            }
                        }
                       // self.pickerCard
                        HStack {
                            Text("TARJETA")
                             .textStyle(TitleStyle())
                            RadioButtonGroups { selected in
                                print("Selected card is: \(selected)")
                                self.validationVM.cardtype = selected.lowercased()
                            }
                        }.padding()
                        Spacer()
                    }
                    Button(action:{
                        
                        self.cards.saveCard(card_nombre: self.validationVM.nameCard, card_number: self.validationVM.cardNumber , card_expiry_date: self.validationVM.date , card_cvn: self.validationVM.cvv , card_type: self.validationVM.cardtype)
                        self.alertState = true
                      //  print(self.validationVM.cardtype)
                        //print(self.selectedId)
                    }){
                        Text("Aceptar")
                            .foregroundColor(Color.white)
                            .frame(maxWidth:.infinity)
                            .padding(8)
                            .background(Color("primary"))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    }
                    .opacity(validationVM.isValidationComplete ? 1 : 0.6)
                    .disabled(!validationVM.isValidationComplete)
                }
                if self.cardsVM.isloading == true{
                    Loader()
                }
            }
        }.padding()
        .alert(isPresented:  self.$alertState){
            self.alerts
        }
    }
    var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Se guardo exitosamente."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
           // self.navigationRoot.setRootView()
        }))
    }
}

struct FormCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        FormCreditCardView()
    }
}

struct EntryField: View {
    var placeHolder: String
    var prompt: String
    @Binding var field: String
    var isSecure:Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isSecure {
                    SecureField(placeHolder, text: $field).autocapitalization(.none)
                    
                } else {
                    TextField(placeHolder, text: $field).autocapitalization(.none)
                        
                }
            }
            .padding(.horizontal,12)
            .padding(.vertical,8)
            .background(Color("input"))
            .clipShape(Capsule())
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}

/*
 VStack(alignment: .leading, spacing: 8){
     Text("BANCO")
         .textStyle(TitleStyle())
     TextField("Nombre banco", text:  self.$card_nombre)
         .textFieldStyle(Input())
     Text("NÚMERO")
         .textStyle(TitleStyle())
     TextField("Número", text:  self.$card_number)
         .textFieldStyle(Input())
         
         .onChange(of: card_number) {
             print($0)
             if $0.count == 4 || $0.count == 9 || $0.count == 14 {
                 self.card_number = $0 + self.space
                 //print(self.numberCard)
                 //print("ya llego a 4")
             }
         }
         .onReceive(Just(card_number)) { value in
             let shortString = String(value.prefix(19))
             if shortString != value {
                 self.card_number = shortString
             }
         }
     
     HStack{
         VStack(alignment: .leading){
             Text("MES / AÑO")
                 .textStyle(TitleStyle())
             TextField("Mes / Año", text:  self.$card_expiry_date)
                 .textFieldStyle(Input())
                 .onChange(of: card_expiry_date) {
                     print($0)
                     if $0.count == 2  {
                         self.card_expiry_date = $0 + self.space + "/" + self.space
                         //print(self.fecha)
                         //print("ya llego a 4")
                     }
                 }
                 .onReceive(Just(card_expiry_date)) { value in
                     let shortString = String(value.prefix(7))
                     if shortString != value {
                         self.card_expiry_date = shortString
                     }
                 }
         }
         VStack(alignment: .leading){
             Text("CVV")
                 .textStyle(TitleStyle())
             TextField("CVV", text:  self.$card_cvn)
                 .textFieldStyle(Input())
                 
                 .onChange(of: card_cvn) {
                     print($0)
                     if $0.count == 3  {
                         print("llego limite")
                         //print("ya llego a 4")
                     }
                 }
                 .onReceive(Just(card_cvn)) { value in
                     let shortString = String(value.prefix(3))
                     if shortString != value {
                         self.card_cvn = shortString
                     }
                 }
             
         }
     }
     self.pickerCard
     Spacer()
     Button(action: {
         self.cards.saveCard(card_nombre: self.card_nombre, card_number: self.card_number, card_expiry_date: self.card_expiry_date, card_cvn: self.card_cvn, card_type: self.card)
         self.alertState = true
     }){
         Text("Aceptar")
             .foregroundColor(Color.white)
             .frame(maxWidth:.infinity)
             .padding(8)
             .background(Color("primary"))
             .clipShape(Capsule())
             .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
     }
 }
 */
