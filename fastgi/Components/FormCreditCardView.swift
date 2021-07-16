//
//  FormCreditCardView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI
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
    //testcard
    @State var test: String = "0123456789"
    @ObservedObject var cards = Cards()
    @ObservedObject var cardsVM = CardsViewModel()
    @State var alertState: Bool = false
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                VStack(alignment: .leading, spacing: 8){
                   /* Text("TITULAR")
                        .textStyle(TitleStyle())
                    TextField("Nombre titutlar", text:  self.$testForm)
                        .textFieldStyle(Input())
                        Text("NÚMERO")
                            .textStyle(TitleStyle())
                    TextField("Número", text:  self.$testForm)
                        .textFieldStyle(Input())
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("MES / AÑO")
                                .textStyle(TitleStyle())
                            TextField("Mes / Año", text:  self.$testForm)
                                .textFieldStyle(Input())
                        }
                        VStack(alignment: .leading){
                            Text("CVV")
                                .textStyle(TitleStyle())
                            TextField("CVV", text:  self.$testForm)
                                .textFieldStyle(Input())
                        }
                    }
                    Text("DIRECCION")
                        .textStyle(TitleStyle())
                    TextField("Direccion", text:  self.$testForm)
                        .textFieldStyle(Input())
                    self.pickerCity
                    Button(action: {
                        print("envio\(self.testForm)")
                    }){
                        Text("Aceptar")
                            .foregroundColor(Color.white)
                            .frame(maxWidth:.infinity)
                            .padding(8)
                            .background(Color("primary"))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    }*/
                    Text("BANCO")
                         .textStyle(TitleStyle())
                     TextField("Nombre banco", text:  self.$card_nombre)
                         .textFieldStyle(Input())
                         Text("NÚMERO")
                             .textStyle(TitleStyle())
                     TextField("Número", text:  self.$card_number)
                         .textFieldStyle(Input())
                     
                     HStack{
                         VStack(alignment: .leading){
                             Text("MES / AÑO")
                                 .textStyle(TitleStyle())
                             TextField("Mes / Año", text:  self.$card_expiry_date)
                                 .textFieldStyle(Input())
                         }
                         VStack(alignment: .leading){
                             Text("CVV")
                                 .textStyle(TitleStyle())
                             TextField("CVV", text:  self.$card_cvn)
                                 .textFieldStyle(Input())
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
                   
                   /* Button(action: {
                        self.test.removeFirst(5)
                        print(self.test)
                    }){
                        Text("Print")
                            .foregroundColor(Color.white)
                            .frame(maxWidth:.infinity)
                            .padding(8)
                            .background(Color("primary"))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 3)
                    }*/
                    
                    if self.cardsVM.isloading == true{
                        Loader()
                    }
                    
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
