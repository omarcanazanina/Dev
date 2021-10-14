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
    @Binding var cardNumber1 : String
    @Binding var idCard1 : String
    //navigation
    @State private var action:Int? = 0
    @State var validateCvv: String = ""
    @State var cardNumber: String = ""
    @State var idCard: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(cardNumber1: Binding<String>, idCard1: Binding<String>) {
        self._cardNumber1 = cardNumber1
        self._idCard1 = idCard1
        self.CardsVM.listCards()
    }
    
   /* init(idCard: Binding<String>) {
         self._idCard = idCard
         self.CardsVM.listCards()
     }*/
    
    var body: some View {
        VStack{
            ScrollView(.horizontal)
            {
                HStack{
                    FastgiCardView()
                    ForEach(self.CardsVM.ListCards, id: \.self._id){ (card:CardModel) in
                        //NavigationLink(destination: ValidateCvvView(validateCvv: self.validateCvv)) {
                             Button(action: {
                                 //self.alertState = true
                                 self.action = 1
                                 self.validateCvv = card.card_cvn
                                self.cardNumber = card.card_number
                                self.cardNumber1 = card.card_number
                                self.idCard = card._id
                                self.idCard1 = card._id
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
                    NavigationLink(destination: ValidateCvvView(validateCvv: self.validateCvv, cardNumber: self.$cardNumber, idCard: self.$idCard), tag: 1, selection: self.$action) {
                          EmptyView()
                      }
                    
                    
                    /*CreditCardView(logo: "mastercard")
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()
                    CreditCardView()*/
                }
                .padding()
            }.frame(alignment:.topLeading)

            NavigationLink(destination: FormCreditCardView()) {
             Text("+ Agregar tarjeta")
                 .foregroundColor(Color("primary"))
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment:.topLeading)
        .navigationBarTitle("Tarjeta", displayMode: .inline)
    }
}

/*struct SelectCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCreditCardView()
    }
}*/


