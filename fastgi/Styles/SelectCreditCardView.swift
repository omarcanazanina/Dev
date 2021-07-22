//
//  SelectCreditCardView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct SelectCreditCardView: View {
    @ObservedObject var cards = Cards()
    @ObservedObject var CardsVM = CardsViewModel()
    //envio de cardNumber a formLoadcredit
    //@Binding var cardNumber : String
    @Binding var idCard : String
    //navigation
    @State private var action:Int? = 0
    @State var validateCvv: String = ""
    @State var cardNumber: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //alert
    //@State var alertState: Bool = false
    
   
   /* init(cardNumber: Binding<String>, idCard: Binding<String>) {
        self._cardNumber = cardNumber
        self._idCard = idCard
        self.CardsVM.listCards()
    }*/
    
    init(idCard: Binding<String>) {
         self._idCard = idCard
         self.CardsVM.listCards()
     }
    
    var body: some View {
        VStack{
            ScrollView(.horizontal)
            {
                HStack{
                    ForEach(self.CardsVM.ListCards, id: \.self._id){ (card:CardModel) in
                        //NavigationLink(destination: ValidateCvvView(validateCvv: self.validateCvv)) {
                             Button(action: {
                                 //self.alertState = true
                                 self.action = 1
                                 self.validateCvv = card.card_cvn
                                self.cardNumber = card.card_number
                               /*  self.cardNumber = card.card_number
                                 self.idCard = card._id
                                 self.presentationMode.wrappedValue.dismiss()*/
                             }){
                                 CreditCardView(logo: card.card_type, bank: card.card_nombre, dateExp: card.card_expiry_date, number: "1234", id_card: card._id)
                             }
                     //   }
                       
                            /* Button(action: {
                            //self.alertState = true
                            self.action = 1
                            self.validateCvv = card.card_cvn
                            
                          /*  self.cardNumber = card.card_number
                            self.idCard = card._id
                            self.presentationMode.wrappedValue.dismiss()*/
                        }){
                            CreditCardView(logo: card.card_type, bank: card.card_nombre, dateExp: card.card_expiry_date, number: "1234", id_card: card._id)
                        }*/
                    }
                    NavigationLink(destination: ValidateCvvView(validateCvv: self.validateCvv, cardNumber: self.$cardNumber), tag: 1, selection: self.$action) {
                          EmptyView()
                      }
                    
                    
                    /*CreditCardView(logo: "mastercard")
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()*/
                }
               /* .alert(isPresented:  self.$alertState){
                    self.alerts
                }*/
                
                .padding()
              
            }.frame(alignment:.topLeading)

            NavigationLink(destination: FormCreditCardView()) {
             Text("+ Agregar tarjeta")
                 .foregroundColor(Color("primary"))
            }
            /*VStack{
                Button(action: {
                    self.cardNumber = "1234"
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("envio")
                }
            }*/
            
           /* VStack {
                Text("View 1")
                    .font(.headline)
                NavigationLink(destination: ValidateCvvView(validateCvv: self.validateCvv)) {
                    Text("View 2")
                        .font(.headline)
                }
            }
            */
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment:.topLeading)
        .navigationBarTitle("Tarjeta", displayMode: .inline)
    }
    
    /*var alerts:Alert{
        Alert(title: Text("Fastgi"), message: Text("Se guardo exitosamente."), dismissButton: .default(Text("Aceptar"), action: {
            self.presentationMode.wrappedValue.dismiss()
           // self.navigationRoot.setRootView()
        }))
    }*/
    
}

/*struct SelectCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCreditCardView()
    }
}*/


