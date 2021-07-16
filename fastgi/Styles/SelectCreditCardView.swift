//
//  SelectCreditCardView.swift
//  fastgi
//
//  Created by Hegaro on 04/11/2020.
//

import SwiftUI

struct SelectCreditCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var cards = Cards()
    @ObservedObject var CardsVM = CardsViewModel()
    //envio de cardNumber a formLoadcredit
    @Binding var cardNumber : String
    @Binding var idCard : String
    init(cardNumber: Binding<String>, idCard: Binding<String>) {
        self._cardNumber = cardNumber
        self._idCard = idCard
        self.CardsVM.listCards()
    }
    
    var body: some View {
        VStack{
            ScrollView(.horizontal)
            {
                HStack{
                    ForEach(self.CardsVM.ListCards, id: \.self._id){ (card:CardModel) in
                        //CreditCardView(logo: card.card_type, bank: card.card_nombre, dateExp: card.card_expiry_date, number: "1234")
                        Button(action: {
                            self.cardNumber = card.card_number
                            self.idCard = card._id
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            CreditCardView(logo: card.card_type, bank: card.card_nombre, dateExp: card.card_expiry_date, number: "1234", id_card: card._id)
                        }
                       
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
            /*VStack{
                Button(action: {
                    self.cardNumber = "1234"
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Text("envio")
                }
            }*/
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


