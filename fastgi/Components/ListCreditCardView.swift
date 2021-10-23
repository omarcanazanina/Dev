//
//  ListCreditCardView.swift
//  fastgi
//
//  Created by Amilkar on 11/6/20.
//

import SwiftUI

struct ListCreditCardView: View {
    
    @State private var cards = ["mastercard", "visa", "mastercard", "visa", "visa"]
    @ObservedObject var CardsVM = CardsViewModel()
    var body: some View {
        VStack{
                List {
                   /* ForEach(cards, id: \.self) { card in
                        //Text(card)
                        ItemListCreditCardView(logo: card)
                    }*/
                    Text("Fastgi")
                    Text("Fastgi1")
                    ForEach(self.CardsVM.ListCards, id: \.self._id){ (card:CardModel) in
                        //NavigationLink(destination: ValidateCvvView(validateCvv: self.validateCvv)) {
                        Text("card.card_nombre")
                        //ItemListCreditCardView(logo: card.card_cvn)
                            /* Button(action: {
                                 //self.alertState = true
                                 
                             }){
                               
                                 CreditCardView(logo: card.card_type, bank: card.card_nombre, dateExp: card.card_expiry_date, number: "1234", id_card: card._id)
                             }*/
                   
                    }
                    .onDelete(perform: self.deleteRow)
                    
                    NavigationLink(destination: FormCreditCardView()) {
                     Text("+ Agregar tarjeta")
                         .foregroundColor(Color("primary"))
                    }
                }
        }.navigationBarTitle(Text("Mis tarjetas"), displayMode: .inline)
    }
    private func deleteRow(at indexSet: IndexSet) {
          self.cards.remove(atOffsets: indexSet)
      }
}

struct ListCreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCreditCardView()
    }
}
